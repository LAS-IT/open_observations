time = 0
interval = 1
total_time = 40
form_template = '' 
result_template = ''
summary_template = ''

start = () ->
  if $('#interactions').hasClass('waiting')
    init_recording()
  $('#timer').addClass('playing')
  $('.controls').removeClass('hidden')
  time = setInterval ( ->
      update_watch() 
  ), 1000

init_recording = () ->
  $('#interactions').removeClass('waiting')
  $('#instructions').fadeOut ->
    $(@).remove()
  source   = $("#interaction-template").html()
  form_template = Handlebars.compile(source)
  result_source = $("#interaction-result").html()
  result_template = Handlebars.compile(result_source)
  interaction_summary = $("#interaction-summary").html()
  summary_template = Handlebars.compile(interaction_summary)

  context =
    minute: $('.clock > .minute').text()
  html     = form_template(context)
  $('#interactions').append(html).hide().fadeIn()

pause = () ->
  $('#timer').removeClass('playing')
  clearTimeout(time)

complete = () ->
  pause()
  $('.clock').text "Observation Complete"
  $('#progressbar').progressbar "option", 
    value: 100
  $('#progressbar').fadeOut()
  $("#toggle_timer i").fadeOut()

update_watch = () -> 
  minute = parseInt $('.clock > .minute').text()
  second = parseInt $('.clock > .second').text()

  if second == 59 
    minute += 1
    second = 0
  else 
    second++

  if minute == total_time
    complete() 
  else
    $('.minute').text(minute)
    $('.second').text(second.pad())

    if minute > 0 and !(minute % interval) and second == 0
      # Update the Progress Bar
      progress = 100 / total_time * minute
      progress = Math.round progress
      $('#progressbar').progressbar "option", 
        value: progress

      # Add another Template
      context =
        minute: minute
      html = form_template(context)
      $('#interactions').append(html)
      $('#interactions div:last').hide().fadeIn()
      dropZone = document.getElementById("upload_drop_#{minute-1}")
      dropZone = addEventListener('dragover', handle_drag_over, false)
      dropZone = addEventListener('drop', handle_file_drop, false)
      interactions_needing_summaries()

save_record = (minute) ->
  form = $("#interaction_#{minute}_form")
  data = form.serializeObject()
  $.post(
    form.attr('action'),
    data,
    (data, textStatus, jqXHR) ->
      console.log('Success')
      update_result(data)
    'json'
  )
  .done (data) ->
    console.log('Done')
    console.log(data)
  .fail (data) ->
    console.log('Fail')
    form.parent().effect 'highlight',
      color: '#fc8c8f'

update_result = (interaction) ->
  context =
    minute: interaction.minute,
    code_string: interaction.code_string,
    on_task: interaction.on_task,
    using_technology: (if interaction.using_technology == true then 'Yes' else 'No')
    uuid: interaction.uuid
  html = result_template(context)
  $("#interaction_#{interaction.minute}").html html
  interactions_needing_summaries()


handle_file_drop = (event) ->
  console.log event
  event.stopPropagation()
  event.preventDefault()

  div = $(event.toElement).parents('div')
  list =  div.children('ul')
  minute = div.data('minute')

  files = event.dataTransfer.files
  for file in files
    reader = new FileReader()
    reader.onload = (event) ->
      object = {}
      object.filename = file.name
      object.data = event.target.result
      upload_file_to_interaction(div.data('uuid'), object, list)
    reader.readAsDataURL(file)

handle_file_select = (field) ->
  running = $('#timer').hasClass('playing')
  pause() if running
  div = field.parents('div')
  list =  div.children('ul')
  minute = div.data('minute')
  files = field[0].files
  console.log files
  for file in files
    reader = new FileReader()
    reader.onload = (event) ->
      object = {}
      object.filename = file.name
      object.data = event.target.result
      upload_file_to_interaction(div.data('uuid'), object, list)
    reader.readAsDataURL(file)
  start() if running

handle_drag_over = (event) ->
  event.stopPropagation()
  event.preventDefault()
  event.dataTransfer.dropEffect = 'copy'

upload_file_to_interaction = (interaction, file, target) ->
  if interaction
    console.log 'About to upload the file(s)'
    form_data = new FormData()
    form_data.append "media", file.data
    $.ajax
      url: "/interactions/#{interaction}/snapshots"
      type: 'POST'
      data: form_data
      processData: false
      contentType: false
    .done (data, textStatus, xhr) ->
      console.log 'Success'
      target.append "<li><img src='#{data.thumb}'></li>"
    .fail (data) ->
      console.log 'Fail'
      console.log target
      target.parents('.upload_drop').effect 'highlight',
        color: '#fc8c8f'
    .always ->
      $('.upload_drop').removeClass('active')

interactions_needing_summaries = ->
  for minute in [0, 5, 10, 15, 20, 25, 30, 35]
    regex_search = [minute..minute+4].join '|'
    interactions = $(".upload_drop:regex(data-minute,^(#{regex_search})$)")
    if interactions.length == 5
      fade_individual_interactions minute, minute+4
      display_block_summary minute, minute + 4

fade_individual_interactions = (first, last) ->
  for minute in [first..last]
    $("div[data-minute=#{minute}]").fadeOut ->
      if $(@).data('minute') % 5 != 0
        $(@).remove()

display_block_summary = (first, last) ->
  summary_url = document.URL.replace(/start/, "interactions/summarize/#{first}/#{last}")
  $.getJSON  summary_url, 
    dataType: 'json'
    (data) ->
      console.log data
      el = $("div[data-minute=#{first}]")
      context =
        range: data.range,
        code_string: data.code_string,
        on_task: data.on_task,
        using_technology: (if data.using_technology == true then 'Yes' else 'No')
        uuid: data.uuid
      el.html summary_template(context)
      el.fadeIn()

ready = ->
  dropZone = document.getElementsByClassName('upload_drop')
  dropZone = addEventListener('dragover', handle_drag_over, false)
  dropZone = addEventListener('drop', handle_file_drop, false)

  $('#interactions').on 'change', ->
    dropZone = document.getElementsByClassName('upload_drop')
    dropZone = addEventListener('dragover', handle_drag_over, false)
    dropZone = addEventListener('drop', handle_file_drop, false)

  $(document).on 'dragover', '.upload_drop', (e) ->
    $(@).addClass('active')
  $(document).on 'dragleave', '.upload_drop', (e) ->
    $(@).removeClass('active')
  $(document).on 'click', '.snapshot_upload', (e) ->
    e.preventDefault()
    $(@).siblings('input').click()
  $(document).on 'change', '.auto_upload', (e) ->
    handle_file_select $(@)

  $('#toggle_timer').on 'click', (event) ->
    event.preventDefault()
    $("#toggle_timer i").toggleClass('fa-play-circle fa-pause')
    if $('#timer').hasClass('playing')
      pause()
    else
      start()

  $('#save_interactions').on 'click', (event) ->
    event.preventDefault()
    $('.interaction_forms').each (form) ->
      minute = $(@).data('minute')
      save_record(minute)

  $("#progressbar" ).progressbar
    value: 0 

  $(window).scroll ->
    if $(@).scrollTop() > 100 && $('header.full_header').hasClass('hidden')
      $('header.full_header').slideDown()
    else
      $('header.full_header').slideUp()

$(document).ready ready
$(document).on('page:load', ready)