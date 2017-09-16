Tagger application
# Tagger
Building a Folksonomy of Cats.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'tagger', :git => 'git@github.com:bhanubhakta/tagger.git'
```

And then execute:
```bash
$ bundle
$ bundle exec rake tagger:install:migrations
$ bundle exec rake db:migrate
$ 
```

Or install it yourself as:
```bash 
$ gem install tagger
```
How to intergate with rails app:
  1. Add ```acts_as_taggable``` in the model you want to tag
    Example
    ```
      class Dog < ActiveRecord::Base
        acts_as_taggable
      end
    ```
  2. Update all environment files with: Tagger.set_tagged_klass('<class_
  name_of_the_taggable_model>')
    Example development.rb
      ```
        Rails.application.configure do

          ...

          Tagger.set_tagged_klass('Dog')
        end
      ```
  3. Mount routes using ```mount_tagger``` in routes.rb
    Example route.rb
      ```
        Rails.application.routes.draw do

          ...

          mount_tagger
        end
      ```
Limitations:
  1. We have to manually update the tagged_klass in environment files.
  2. Selection of where to mount the routes is not there.
  3. API credentials are not being used. This has to be integrated.
  4. Haven’t performed security and vulnerability tests.

Future enhancements:
  1. Have initializers for not updating the configs manually.
  2. Make mounting of routes configureable.

##### Available APIs

For the taggable class, we can either use the class's name or
'breed'. Example: For Dog model we can use '/tagger/api/v1/dogs' or '/tagger/api/v1/breeds'. Both will return the same results.

```
POST /tagger/api/v1/dogs

  input:
    name: The name of the breed.
    tags: An array of tags to be tagged.
    params = {
      name: 'Norwegian Forest Cat',
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

##### Tag CRUD

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

POST /tagger/api/v1/breeds/:id/tags

- Replaces tags on a breed
- Tags, e.g. ['low shedding', 'pet friendly']

GET /tagger/api/v1/tags

- returns all tags in the system

GET /tagger/api/v1/tags/:id

- returns a tag

PATCH /tagger/api/v1/tags/:id

- updates a tag

DELETE /tagger/api/v1/tags/:id

- deletes the tag and all associations to breeds
```

#### Breed & Tag Stats

```
GET /tagger/api/v1/breeds/stats
- Retrieves statistics about all breeds
- breeds: [
    {
      id: 1,
      name: 'American Bobcat',
      tag_count: 4,
      tag_ids: [1, 2, 3, 4]
    },
    {
      id: 2,
      name: 'Cymric',
      tag_count: 3,
      breed_ids: [1, 4, 5]
    }
  ]


GET /tagger/api/v1/tags/stats

- Retrieves statistics about all tags
- tags: [
    {
      id: 1,
      name: 'has no tail',
      breed_count: 1,
      breed_ids: [2]
    },
    {
      id: 2,
      name: 'affectionate',
      breed_count: 2,
      breed_ids: [1, 2]
    }
  ]
```
  
## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).