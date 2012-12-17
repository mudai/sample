class Bear.Models.Post extends Backbone.Model
  paramRoot: 'post'

  defaults:
    title: null
    content: null

class Bear.Collections.PostsCollection extends Backbone.Collection
  model: Bear.Models.Post
  url: '/posts'
