# Tagger

Tagger is a flexible tagger solution for Rails application where any enitiy e.g cat, dog, etc. can be tagged. 

## It:

Is Rack based.

Is a complete MVC solution based on Rails engines.

Allows you to tag a model.

## Using tagger
## Installation Steps

Tagger is tested in rails 5.1.4. Ruby version ruby-2.3.1

Add this line to your application's Gemfile:

```ruby
gem 'tagger', :git => 'git@github.com:bhanubhakta/tagger.git'
```

Then run ```bundle install```

Next, you need to run generator:
```bash
  $ bundle exec rake tagger:install:migrations
  $ bundle exec rake db:migrate
```

Integrating with your rails app:

  1. Add ```acts_as_taggable``` in the model you want to tag

    Example

      class Dog < ActiveRecord::Base
        acts_as_taggable
      end

  2. Update all environment files with: 

  Tagger.set_tagged_klass('<class_
  name_of_the_taggable_model>')


    Example development.rb

        Rails.application.configure do

          ...

          Tagger.set_tagged_klass('Dog')
        end

  3. Mount routes using ```mount_tagger``` in routes.rb

    Example route.rb

        Rails.application.routes.draw do

          ...

          mount_tagger
        end
        

### Limitations:
  1. We have to manually update the tagged_klass in environment files.
  2. Tagger can be used to tag a single model for now. This can be extended so that it can be used by multiple models in the same rails application.
  3. API authentication is not being used. This layer needs to be added for security.
  4. Haven’t performed security and vulnerability tests.

### Future enhancements:
  1. Have initializers instead of updating the configs manually.
  2. Make mounting of routes configureable.
  3. Have verbose error response for API.

### DEMO
The following rails app is an example of how to integrate
'tagger' into the app. The app has a model called 'Dog' which 'acts_as_taggable'. The rails app version is 5.1.4.

Github link:

https://github.com/bhanubhakta/unicorn

The following is the 'unicorn' app hosted in heroku for demo. All the endpoints from 'Available APIs' section can be accessed.

https://vast-stream-64886.herokuapp.com/tagger/api/v1/dogs

### Explanation for route structure

I have used the ‘api/:version/:resource’ url format for the API to be used as:

1. It gives us plenty of room to work on future versions while still maintaining the older versions.
2. We could have a normal website running in the base url, using this layout helps seem less integration of different services but using the same base url/hostname.
3. Testing will be easier.

### Available APIs

For the taggable class, we can either use the class's name or
'breed'. Example: For Dog model we can use '/tagger/api/v1/dogs' or '/tagger/api/v1/breeds'. Both will return the same results.

```
POST /tagger/api/v1/dogs

  input:
    name: The name of the breed.
    tags: An array of tags to be tagged.
    params = {
      name: 'German Sheperd',
      tags: ["Knows Kung Fu", "Climbs Trees"]
    }

  response:

  {
    "dogs": {
        "id": 1,
        "name": "German Sheperd",
        "created_at": "2017-09-16T06:07:53.800Z",
        "updated_at": "2017-09-16T06:07:53.800Z"
    },
    "tags": [
        {
            "id": 1,
            "name": "Knows Kung Fu",
            "created_at": "2017-09-16T06:07:53.843Z",
            "updated_at": "2017-09-16T06:07:53.843Z"
        },
        {
            "id": 2,
            "name": "Climbs Trees",
            "created_at": "2017-09-16T06:07:53.852Z",
            "updated_at": "2017-09-16T06:07:53.852Z"
        }
    ]
  }

GET /tagger/api/v1/dogs

- returns all dogs

response:

[
  {
      "id": 1,
      "name": "German Sheperd",
      "created_at": "2017-09-16T06:07:53.800Z",
      "updated_at": "2017-09-16T06:07:53.800Z"
  }
]

GET /tagger/api/v1/dogs/:id

- returns the dogs and all the tags belonging to it

response: {
  "dogs": {
      "id": 1,
      "name": "German Sheperd",
      "created_at": "2017-09-16T06:07:53.800Z",
      "updated_at": "2017-09-16T06:07:53.800Z"
  },
  "tags": [
      {
          "id": 1,
          "name": "Knows Kung Fu",
          "created_at": "2017-09-16T06:07:53.843Z",
          "updated_at": "2017-09-16T06:07:53.843Z"
      },
      {
          "id": 2,
          "name": "Climbs Trees",
          "created_at": "2017-09-16T06:07:53.852Z",
          "updated_at": "2017-09-16T06:07:53.852Z"
      }
  ]
}

PATCH /tagger/api/v1/dogs/:id

- Updates the dog and it's tags

input:
  name: German Sheperd
  tags: ["Barks hard", "Climbs Trees"]

response: {
  "dogs": {
      "id": 1,
      "name": "German Sheperd",
      "created_at": "2017-09-16T06:07:53.800Z",
      "updated_at": "2017-09-16T06:30:04.083Z"
  },
  "tags": [
      {
          "id": 3,
          "name": "Barks hard",
          "created_at": "2017-09-16T06:30:04.101Z",
          "updated_at": "2017-09-16T06:30:04.101Z"
      },
      {
          "id": 2,
          "name": "Climbs Trees",
          "created_at": "2017-09-16T06:07:53.852Z",
          "updated_at": "2017-09-16T06:07:53.852Z"
      }
  ]
}

DELETE /tagger/api/v1/dogs/:id

- Removes the dog
  response: 
  { "message": "Deleted successfully" }

```

### Tag CRUD

```
GET /tagger/api/v1/dogs/:id/tags

- Gets tags on a dog

response: {
  "tags": [
    {
        "id": 4,
        "name": "Barks hard",
        "created_at": "2017-09-16T06:44:27.260Z",
        "updated_at": "2017-09-16T06:44:27.260Z"
    },
    {
        "id": 5,
        "name": "Climbs Trees",
        "created_at": "2017-09-16T06:44:27.318Z",
        "updated_at": "2017-09-16T06:44:27.318Z"
    }
  ]
}

POST /tagger/api/v1/dogs/:id/tags
- Replaces tags on a dog
  input:
    tags: ['low shedding', 'pet friendly']

  response: {
    "dogs": {
      "name": "German Sheperd",
      "id": 2,
      "created_at": "2017-09-16T06:44:27.031Z",
      "updated_at": "2017-09-16T06:44:27.031Z"
    },
    "tags": [
      {
          "id": 6,
          "name": "low shedding",
          "created_at": "2017-09-16T06:47:01.401Z",
          "updated_at": "2017-09-16T06:47:01.401Z"
      },
      {
          "id": 7,
          "name": "pet friendly",
          "created_at": "2017-09-16T06:47:01.469Z",
          "updated_at": "2017-09-16T06:47:01.469Z"
      }
    ]
  }

GET /tagger/api/v1/tags

- returns all tags in the system

response: 
[
  {
    "id": 1,
    "name": "Knows Kung Fu",
    "created_at": "2017-09-16T06:07:53.843Z",
    "updated_at": "2017-09-16T06:07:53.843Z"
  },
  {
    "id": 2,
    "name": "Barks hard",
    "created_at": "2017-09-16T06:44:27.260Z",
    "updated_at": "2017-09-16T06:44:27.260Z"
  }
]

GET /tagger/api/v1/tags/:id

- returns a tag

response: 
{
  "id": 1,
  "name": "Knows Kung Fu",
  "created_at": "2017-09-16T06:07:53.843Z",
  "updated_at": "2017-09-16T06:07:53.843Z"
}

PATCH /tagger/api/v1/tags/:id

- updates a tag

input:
  name: Name of the tag to be updated.

response:
{
  "id": 1,
  "name": "Golden Retriever",
  "created_at": "2017-09-16T06:07:53.843Z",
  "updated_at": "2017-09-16T06:59:18.669Z"
}

DELETE /tagger/api/v1/tags/:id

- deletes the tag and all associations to breeds
response:

{
  "message": "Deleted successfully"
}

```

#### Breed & Tag Stats

```
GET /tagger/api/v1/dogs/stats
- Retrieves statistics about all dogs

response:

dogs: [
  {
    "id": 2,
    "name": "German Sheperd",
    "tag_count": 2,
    "tag_ids": [
      6,
      7
    ]
  }
]


GET /tagger/api/v1/tags/stats

- Retrieves statistics about all tags
response:

tags: 
[{
  "id": 6,
  "name": "low shedding",
  "entity_count": 1,
  "entity_ids": [
      2
  ]
},
{
  "id": 7,
  "name": "pet friendly",
  "entity_count": 1,
  "entity_ids": [
      2
  ]
}]
```
  
## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).