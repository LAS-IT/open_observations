ready = ->
  $('.chzn').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '450px'

  setTimeout ->
    $('.flash').fadeOut()
  , 2000

$(document).ready ready
$(document).on('page:load', ready)

Number.prototype.pad = (size) -> 
  s = String(@);
  if typeof(size) != "number"
    size = 2;
  while s.length < size
    s = "0" + s;
  s

$.fn.serializeObject = ->

  json = {}
  push_counters = {}
  patterns =
    validate  : /^[a-zA-Z][a-zA-Z0-9_]*(?:\[(?:\d*|[a-zA-Z0-9_]+)\])*$/,
    key       : /[a-zA-Z0-9_]+|(?=\[\])/g,
    push      : /^$/,
    fixed     : /^\d+$/,
    named     : /^[a-zA-Z0-9_]+$/

  @build = (base, key, value) ->
    base[key] = value
    base

  @push_counter = (key) ->
    push_counters[key] = 0 if push_counters[key] is undefined
    push_counters[key]++

  $.each $(@).serializeArray(), (i, elem) =>
    return unless patterns.validate.test(elem.name)

    keys = elem.name.match patterns.key
    merge = elem.value
    reverse_key = elem.name

    while (k = keys.pop()) isnt undefined

      if patterns.push.test k 
        re = new RegExp("\\[#{k}\\]$")
        reverse_key = reverse_key.replace re, ''
        merge = @build [], @push_counter(reverse_key), merge

      else if patterns.fixed.test k 
        merge = @build [], k, merge

      else if patterns.named.test k
        merge = @build {}, k, merge

    json = $.extend true, json, merge

  return json