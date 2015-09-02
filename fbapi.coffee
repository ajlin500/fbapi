class FbApi
  constructor: (fbAuth) ->
    if fbAuth
      @auth = fbAuth
    else
      # Auth current user
      fbAuth = new FbAuth()
      fbAuth.authCurrentUser()
      @auth = fbAuth

  baseApiUrl: 'https://graph.facebook.com'
  version: 'v2.4'
  api: ->
    return "#{@baseApiUrl}/#{@version}"

  call: (type, urlFragment, params = {}) ->
    url = @api() + urlFragment
    @_call type, url, params

  _call: (type, url, params = {}) ->
    params.access_token = @auth?.accessToken
    options =
      params: params
    response = HTTP.call type, url, options
    return response.data

  get: (urlFragment, params) ->
    @call 'GET', urlFragment, params

  post: (urlFragment, params) ->
    @call 'POST', urlFragment, params

  pageThroughResults: (response, data = []) ->
    data = data.concat response.data
    next = response.paging.next
    if next
      response = @_call next
      return pageThroughResults response, data
    else
      return data

  # Docs:
  # https://developers.facebook.com/docs/graph-api/reference/user/accounts/
  getUserPages: ->
    url = '/me/accounts'
    response = @get url
    @pageThroughResults response

  # Docs:
  # https://developers.facebook.com/docs/marketing-api/reference/ad-account
  getUserAdAccounts: ->
    url = '/me/adaccounts'
    params =
      fields: 'name, account_status'
    response = @get url, params
    @pageThroughResults response

  # Docs:
  # https://developers.facebook.com/docs/graph-api/reference/v2.4/page/feed
  createPagePost: (pageId, params = {}) ->
    url = "/#{pageId}/feed"
    # Defaults to unpublished if not specified
    params.published or= 0
    @post url, params

  # Docs:
  # https://developers.facebook.com/docs/marketing-api/generatepreview/v2.4
  generateAdPreview: (adAccount, params = {}) ->
    url = "/#{adAccount}/generatepreviews"
    response = @get url, params
    return response.data[0].body

  # Docs:
  # https://developers.facebook.com/docs/marketing-api/adcreative/v2.4
  createAdCreative: (adAccount, params = {}) ->
    url = "/#{adAccount}/adcreatives"
    @post url, params

  # Docs:
  # https://developers.facebook.com/docs/marketing-api/reference/ad-campaign-group
  createAdCampaign: (adAccount, params = {}) ->
    url = "/#{adAccount}/adcampaign_groups/"
    @post url, params

  # Docs:
  # https://developers.facebook.com/docs/marketing-api/reference/ad-campaign
  createAdSet: (adAccount, params = {}) ->
    url = "/#{adAccount}/adcampaigns"
    @post url, params

  # Docs:
  # https://developers.facebook.com/docs/marketing-api/adgroup/v2.4
  createAd: (adAccount, params = {}) ->
    url = "/#{adAccount}/adgroups"
    @post url, params

  # Docs:
  # https://developers.facebook.com/docs/marketing-api/targeting-search/v2.4
  search: (params = {}) ->
    url = "/search"
    @get(url, params).data

  ###
  # Edges
  #   Valid objectIds:
  #
  #   Docs:
  #   https://developers.facebook.com/docs/marketing-api/reference/ad-campaign-group
  #   AdCampaign: adcampaigns(ad sets), adgroups(ads), insights, stats
  #
  #   Docs:
  #   https://developers.facebook.com/docs/marketing-api/reference/ad-campaign
  #   AdSets: activities, adcreatives, adgroups(ads), asyncadgrouprequests,
  #     reachestimate, targetingsentencelines, insights, conversions, stats
  #
  #   Docs:
  #   https://developers.facebook.com/docs/marketing-api/adgroup/v2.4
  #   Ad: adcreatives, keywordstats, previews, reachestimate, stats,
  #     targetingsentencelines, trackingtag, conversions, insights
  #
  ###
  getAdsEdge: (objectId, params = {}) ->
    url = "/#{objectId}/adgroups"
    @get(url, params).data

  getAdSetsEdge: (objectId, params = {}) ->
    url = "/#{objectId}/adcampaigns"
    @get(url, params).data

  getInsightsEdge: (objectId, params = {}) ->
    url = "/#{objectId}/insights"
    @get(url, params).data

  getReachEstimateEdge: (objectId, params = {}) ->
    url = "/#{objectId}/reachestimate"
    @get(url, params).data

