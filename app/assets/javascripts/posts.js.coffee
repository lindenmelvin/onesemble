$(document).on 'ajax:success', (xhr, data, status) ->
  $('#posts-container').empty()
  if data.posts.length
    for post in data.posts
      if post[9]
        rate_string = parseFloat(post[8]).toFixed(2) + ' / hour' 
      else
        rate_string = parseFloat(post[8]).toFixed(2)
      $('#posts-container').append("
        <div class='post'>
          <div>#{post[10]}</div>
          <div>Posted at: #{post[0]} </div>
          <div>Post by: #{post[1]} </div>
          <div>Subject: #{post[2]} </div>
          <div>Body: #{post[3]} </div>
          <div>Instruments: #{post[4]} </div>
          <div>Genres: #{post[5]} </div>
          <div>Specialties: #{post[6]} </div>
          <div> Rate: $#{rate_string} </div>
          <div>Location: #{post[11]}, #{post[12]}</div>
          <div>Start: #{post[13]}</div>
          <div>End: #{post[14]}</div>
        </div>
        <a href='#{post[7]}'>View Post</a>
      ")
  else
    $('#posts-container').append('<div> No posts match your search criteria. </div>')

$(document).on 'ready', ->
  if $('#all-day:checked').length 
    $('#post_start_date_4i, #post_start_date_5i, #post_end_date_4i, #post_end_date_5i').attr('disabled', true)
  
  $('.state-select').on 'change', (event) ->
    cities = $('.state-select option:selected').data('cities')
    $('.city-select').empty()
    for city in cities
      $('.city-select').append("<option value='#{city.id}'>#{city.name}</option>")
      
  $('#all-day').on 'change', (event) ->
    if $('#all-day:checked').length
      $('#post_start_date_4i, #post_start_date_5i, #post_end_date_4i, #post_end_date_5i').attr('disabled', true)
      $('#hidden-all-day').val(true)
    else
      $('#post_start_date_4i, #post_start_date_5i, #post_end_date_4i, #post_end_date_5i').removeAttr('disabled')
      $('#hidden-all-day').val(false)
