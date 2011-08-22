lastFmApiKey    = 'change-me'
recentTracksUrl = 'http://ws.audioscrobbler.com/2.0/?'
campFireKey     = 'change-me'
roomId          = 'change-me'
campfireLatestImagesUrl = 'https://envylabs.campfirenow.com/room/' + roomId + '/uploads.json'

displayImage = (image) ->
  image = '<img src="' + image.full_url + '" height=200 width=100 />'
  $('#imageList').append('<li><a href="#">' + image + '</a></li>');

showLatestImages = (latestImages) ->
  displayImage(image) for image in latestImages.uploads

displayTrack = (user, track) ->
  trackName = track['name']
  trackArtist = track.artist["#text"]
  $('#songList').append("<li>" + trackName + " by <em>" + trackArtist + "</em> (" + user + ")</li>")

showCurrentTrack = (user, response) ->
  recentTracks = response.recenttracks
  currentTrack = recentTracks.track[0]
  currentArtist = currentTrack.artist["#text"]
  currentSong = currentTrack["name"]
  displayTrack(user, track) for track in recentTracks.track

loadRecentActivity = () ->

  for userName in ['envylabs', 'caike']
    do (userName) ->
      lastFmOptions =
        format: 'json'
        method: 'user.getrecenttracks'
        user: userName
        api_key: lastFmApiKey
      $.get(recentTracksUrl, lastFmOptions, (response) -> showCurrentTrack(userName, response))

  campfireOptions =
    url: campfireLatestImagesUrl
    username: campFireKey
    password: 'x'
    success: (response) ->
      showLatestImages(response)

  $.ajax(campfireOptions);

$(() -> loadRecentActivity())