$(document).on 'ajax:success', (xhr, data, status) ->
  $('#posts-container').empty()
  for post in data.posts
    $('#posts-container').append("
      <div class='post'>
        <div>Posted at: #{post[0]} </div>
        <div>Post by: #{post[1]} </div>
        <div>Subject: #{post[2]} </div>
        <div>Body: #{post[3]} </div>
        <div>Instruments: #{post[4]} </div>
        <div>Genres: #{post[5]} </div>
        <div>Specialties: #{post[6]} </div>
        <a href='#{post[7]}'>Edit Post</a>
        <a href='#{post[8]}'>View Post</a>
        <a href='#{post[9]}' data-confirm='Are you sure?' data-method='delete' rel='nofollow'>Destroy</a>
      </div>
    ")
    