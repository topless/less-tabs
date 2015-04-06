class Auth extends Controller
  constructor: (@$scope, @$location, @CONFIG_DB, @AUTH_URLS) ->
    @authButtons()

  authButtons: ->
    # for url in auth_urls -> show: true
    @buttons = [
      { brand: 'Google', class: 'btn-google', loading: false, show: true, icon: 'fa-google', url: @AUTH_URLS["gae_signin_url"]}
      { brand: 'Facebook', class: 'btn-facebook', loading: false, show: false, icon: 'fa-facebook', url: @AUTH_URLS["facebook_signin_url"]}
      { brand: 'Twitter', class: 'btn-twitter', loading: false, show: false, icon: 'fa-twitter', url: @AUTH_URLS["twitter_signin_url"]}
      { brand: 'Bitbucket', class: 'btn-bitbucket', loading: false, show: false, icon: 'fa-bitbucket', url: @AUTH_URLS["bitbucket_signin_url"]}
      { brand: 'Dropbox', class: 'btn-dropbox', loading: false, show: false, icon: 'fa-dropbox', url: @AUTH_URLS["dropbox_signin_url"]}
      { brand: 'GitHub', class: 'btn-github', loading: false, show: false, icon: 'fa-github', url: @AUTH_URLS["github_signin_url"]}
      { brand: 'Google', class: 'btn-google', loading: false, show: false, icon: 'fa-google-plus', url: @AUTH_URLS["google_signin_url"]}
      { brand: 'Instagram', class: 'btn-instagram', loading: false, show: false, icon: 'fa-instagram', url: @AUTH_URLS["instagram_signin_url"]}
      { brand: 'LinkedIn', class: 'btn-linkedin', loading: false, show: false, icon: 'fa-linkedin', url: @AUTH_URLS["linkedin_signin_url"]}
      { brand: 'Microsoft', class: 'btn-microsoft', loading: false, show: false, icon: 'fa-windows', url: @AUTH_URLS["microsoft_signin_url"]}
      { brand: 'VK', class: 'btn-vk', loading: false, show: false, icon: 'fa-vk', url: @AUTH_URLS["vk_signin_url"]}
      { brand: 'Yahoo!', class: 'btn-yahoo', loading: false, show: false, icon: 'fa-yahoo', url: @AUTH_URLS["yahoo_signin_url"]}
    ]

  click: (button) ->
    # ?next is going to be location.path()
    console.log @$location.path()
    console.log button, @AUTH_URLS
    @$location.path(@AUTH_URLS["#{button.brand.toLowerCase()}_signin_url"])
