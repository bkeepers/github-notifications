class app.Collections.Repositories extends Backbone.Collection
  model: app.Models.Repository
  url: 'https://api.github.com/user/subscriptions'
