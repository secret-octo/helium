`
/*
  * better YUI doc here:
  * poker engine prototype
  * also included in this pen is my fork of paralleljs
  */
`
`
/*
  * better YUI doc here:
  * main function. The one to be run at the end of the script.
  */
`
main = ->
  p = new Parallel()
  p.spawn handEval
  p.then (data) ->
    document.getElementById('output').innerHTML = JSON.parse(data).innerHTML.replace(/\n/g, '<br\>')
  console.log "------------------------"
  console.log "returned promise"

`
/**
  * better YUI doc here:
  * this method runs inside a webworker
  * or fork child_process on nodejs
  */
`
handEval =  ->
  # this method wil be excuted inside a webworker
  output = {innerHTML: ""}
  names = [0, 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
  A = 14
  K = 13
  Q = 12
  J = 11
  T = 10
  _ =
    "♠": 1
    "♣": 2
    "♥": 4
    "♦": 8

  get5cardScore = (cs, ss) ->
    d = {}
    s = 1 << cs[0] | 1 << cs[1] | 1 << cs[2] | 1 << cs[3] | 1 << cs[4]
    i = v = o = 0
    while i < 5
      o = Math.pow(2, cs[i] * 4)
      v += o * (d[cs[i]] = (v / o & 15) + 1)
      i++
    v = v % 15 - ((if (s / (s & -s) is 31) or (s is 0x403c) then 3 else 1)) - (ss[0] is (ss[1] | ss[2] | ss[3] | ss[4])) * (if s is 0x7c00 then -5 else 1)
    c = if s is 0x403c then [5, 4, 3, 2, 1] else cs.slice().sort (a, b) ->
      if d[a] < d[b]
        1
      else
        if d[a] > d[b]
          -1
        else
          b - a
    
    ([7, 8, 4, 5, 0, 1, 2, 9, 3, 6][v] << 20 | c[0] << 16 | c[1] << 12 | c[2] << 8 | c[3] << 4 | c[4])

  getTypeDetail = (x) ->
    cat = x >> 20
    c1 = x >> 16 & 15
    c2 = x >> 12 & 15
    c3 = x >> 8 & 15
    c4 = x >> 4 & 15

    
    console.log "#{x} -- #{cat} -- 1: #{c1} -- 2: #{c2} -- 3: #{c3} -- 4: #{c4}"
    
    switch cat
      when 0
        names[c1] + " high"
      when 1
        "Pair of " + names[c1] + "s"
      when 2
        "Two pair, " + names[c1] + "s and " + names[c3] + "s"
      when 3
        "Three of a kind, " + names[c1] + "s"
      when 4
        #return "low straight"  if names[c1] is 5
        names[c1] + " high straight"
      when 5
        names[c1] + " high flush"
      when 6
        names[c1] + "s full of " + names[c4] + "s"
      when 7
        "Four of a kind, " + names[c1] + "s"
      when 8
        #return "low straight flush"  if names[c1] is 5
        names[c1] + " high straight flush"
      when 9
        "Royal flush"

  date = new Date().getTime()
  counter = 0
  while (date + 1000 * 2) > new Date().getTime()
    h01 = get5cardScore([T, J, Q, K, A], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]])
    h02 = get5cardScore([T, J, Q, K, 9], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]])
    h03 = get5cardScore([2, 3, 4, 5, A], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]])
    h04 = get5cardScore([8, 8, 8, 8, 9], [_["♠"], _["♣"], _["♥"], _["♦"], _["♠"]])
    h05 = get5cardScore([A, A, A, 9, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
    h06 = get5cardScore([T, J, 6, K, 9], [_["♣"], _["♣"], _["♣"], _["♣"], _["♣"]])
    h07 = get5cardScore([T, J, Q, 8, 9], [_["♠"], _["♣"], _["♥"], _["♣"], _["♦"]])
    h08 = get5cardScore([2, 3, 4, 5, A], [_["♠"], _["♣"], _["♥"], _["♣"], _["♦"]])
    h09 = get5cardScore([4, 4, 4, 8, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
    h10 = get5cardScore([7, 7, J, 9, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
    h11 = get5cardScore([6, 6, 3, 5, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
    h12 = get5cardScore([T, 5, 4, 7, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
    h13 = get5cardScore([A, A, A, 8, 8], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
    
    h14 = get5cardScore([T, J, 9, K, Q], [_["♣"], _["♣"], _["♣"], _["♣"], _["♣"]])
    h15 = get5cardScore([3, 5, 4, 2, 6], [_["♠"], _["♣"], _["♥"], _["♦"], _["♣"]])
    h16 = get5cardScore([3, 5, 4, 2, 6], [_["♥"], _["♣"], _["♠"], _["♦"], _["♠"]])
    h17 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♣"], _["♠"], _["♦"], _["♠"]])
    h18 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♣"], _["♥"], _["♣"]])
    h19 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♥"], _["♥"], _["♣"]])
    h20 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♥"], _["♥"], _["♥"]])
    counter += 20

  output.innerHTML = "total hands evaluated: #{counter}, avg hand/milisec: #{((counter)/((new Date().getTime()) - date))}\n"

  h01 = get5cardScore([T, J, Q, K, A], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]])
  h02 = get5cardScore([J, Q, T, K, 9], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]])
  h03 = get5cardScore([2, 5, 3, 4, A], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]])
  h04 = get5cardScore([A, A, A, A, K], [_["♠"], _["♣"], _["♥"], _["♦"], _["♠"]])
  h05 = get5cardScore([A, A, A, 9, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
  h06 = get5cardScore([T, J, 6, K, 9], [_["♣"], _["♣"], _["♣"], _["♣"], _["♣"]])
  h07 = get5cardScore([T, J, Q, 8, 9], [_["♠"], _["♣"], _["♥"], _["♣"], _["♦"]])
  h08 = get5cardScore([2, 3, 4, 5, A], [_["♠"], _["♣"], _["♥"], _["♣"], _["♦"]])
  h09 = get5cardScore([4, 4, 4, 8, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
  h10 = get5cardScore([7, 7, J, 9, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
  h11 = get5cardScore([6, 6, 3, 5, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
  h12 = get5cardScore([T, 5, 4, 7, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
  h13 = get5cardScore([A, A, A, 8, 8], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]])
  
  h14 = get5cardScore([T, J, 9, K, Q], [_["♣"], _["♣"], _["♣"], _["♣"], _["♣"]])
  h15 = get5cardScore([3, 5, 4, 2, 8], [_["♠"], _["♣"], _["♥"], _["♦"], _["♣"]])
  h16 = get5cardScore([3, 5, 4, 2, 7], [_["♥"], _["♣"], _["♠"], _["♦"], _["♠"]])
  h17 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♣"], _["♠"], _["♦"], _["♠"]])
  h18 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♣"], _["♥"], _["♣"]])
  h19 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♥"], _["♥"], _["♣"]])
  h20 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♥"], _["♥"], _["♥"]])
     
  output.innerHTML += "\ncomparing a few hands:\n"
  output.innerHTML += "====================\n"
  
  
  output.innerHTML += "T♠ J♠ Q♠ K♠ A♠ > J♠ Q♠ T♠ K♠ 9♠ -- " + (h01 > h02) + "\n"
  output.innerHTML += "2♠ 5♠ 3♠ 4♠ A♠ > J♠ Q♠ T♠ K♠ 9♠ -- " + (h03 > h02) + "\n"
  output.innerHTML += "A♠ A♣ A♥ 8♠ 8♣ > A♠ A♣ A♥ 9♦ 9♣ -- " + (h13 > h05) + "\n"
  output.innerHTML += "2♠ 5♠ 3♠ 4♠ A♠ > A♠ A♣ A♥ A♦ K♠ -- " + (h03 > h04) + "\n"
  output.innerHTML += "T♣ J♣ 6♣ K♣ 9♣ > J♠ Q♠ T♠ K♠ 9♠ -- " + (h06 > h02) + "\n"
  output.innerHTML += "T♣ J♣ 9♣ K♣ Q♣ = J♠ Q♠ T♠ K♠ 9♠ -- " + (h14 == h02) + "\n"


  output.innerHTML += "\ntesting hand categorization and score:\n"
  output.innerHTML += "=========================\n"
  output.innerHTML += "01: T♠ J♠ Q♠ K♠ A♠ -- " + getTypeDetail(h01) + " -- #{h01}\n"
  output.innerHTML += "02: T♠ J♠ Q♠ K♠ 9♠ -- " + getTypeDetail(h02) + " -- #{h02}\n"
  output.innerHTML += "03: 2♠ 3♠ 4♠ 5♠ A♠ -- " + getTypeDetail(h03) + " -- #{h03}\n"
  output.innerHTML += "04: 8♠ 8♣ 8♥ 8♦ 9♦ -- " + getTypeDetail(h04) + " -- #{h04}\n"
  output.innerHTML += "05: A♠ A♣ A♥ 9♦ 9♣ -- " + getTypeDetail(h05) + " -- #{h05}\n"
  output.innerHTML += "06: T♣ J♣ 6♣ K♣ 9♣ -- " + getTypeDetail(h06) + " -- #{h06}\n"
  output.innerHTML += "07: T♠ J♣ Q♥ 8♣ 9♦ -- " + getTypeDetail(h07) + " -- #{h07}\n"
  output.innerHTML += "08: 2♠ 3♣ 4♥ 5♦ A♦ -- " + getTypeDetail(h08) + " -- #{h08}\n"
  output.innerHTML += "09: 4♠ 4♣ 4♥ 8♠ 9♣ -- " + getTypeDetail(h09) + " -- #{h09}\n"
  output.innerHTML += "10: 7♠ 7♣ J♥ 9♠ 9♣ -- " + getTypeDetail(h10) + " -- #{h10}\n"
  output.innerHTML += "11: 6♠ 6♣ 3♥ 5♠ 9♣ -- " + getTypeDetail(h11) + " -- #{h11}\n"
  output.innerHTML += "12: T♠ 5♣ 4♥ 7♠ 9♣ -- " + getTypeDetail(h12) + " -- #{h12}\n"
  output.innerHTML += "13: A♠ A♣ A♥ 8♠ 8♣ -- " + getTypeDetail(h13) + " -- #{h13}\n"
  output.innerHTML += "14: T♣ J♣ 9♣ K♣ Q♣ -- " + getTypeDetail(h14) + " -- #{h14}\n"
  output.innerHTML += "15: 3♠ 5♣ 4♠ 2♥ 8♣ -- " + getTypeDetail(h15) + " -- #{h15}\n"
  output.innerHTML += "16: 3♥ 5♣ 4♠ 2♦ 7♠ -- " + getTypeDetail(h16) + " -- #{h16}\n"
  output.innerHTML += "17: A♥ K♣ Q♠ T♠ 9♠ -- " + getTypeDetail(h17) + " -- #{h17}\n"
  output.innerHTML += "18: A♥ K♥ Q♣ T♥ 9♣ -- " + getTypeDetail(h18) + " -- #{h18}\n"
  output.innerHTML += "19: A♥ K♥ Q♥ T♥ 9♣ -- " + getTypeDetail(h19) + " -- #{h10}\n"
  output.innerHTML += "20: A♥ K♥ Q♥ T♥ 9♥ -- " + getTypeDetail(h20) + " -- #{h20}\n"

  

  return JSON.stringify output


`
/**
  * some YUI doc here:
  * the parallel fork in coffee-script
  * the eval.js and worker.js are missing. But its ok because it isn't
  * needed to work on browser. (but ie-10 may have problems, as usual)
  */
`

do ->

  isNode = typeof global isnt "undefined" and {}.toString.call(global) is "[object global]"
  setImmediate = setImmediate or (cb) ->
    setTimeout cb, 0

  defaults = {
    evalPath: ((if isNode then __dirname + "/parallel/eval.js" else null))
    maxWorkers: ((if isNode then require("os").cpus().length else 4))
    synchronous: true
  }

  Worker = ((if isNode then require(__dirname + "/parallel/Worker.js") else self.Worker))
  URL = ((if typeof self isnt "undefined" then ((if self.URL then self.URL else self.webkitURL)) else null))
  _supports = ((if isNode or self.Worker then true else false))
  extend = (from, to) ->
    i = undefined
    to = {}  unless to
    for i of from
      to[i] = from[i]  if to[i] is `undefined`
    to

  Operation = ->
    @_callbacks = []
    @_errCallbacks = []
    @_resolved = 0
    @_result = null
    return

  Parallel = (data, options) ->
    @data = data
    @options = extend(defaults, options)
    @operation = new Operation()
    @operation.resolve null, @data
    @requiredScripts = []
    @requiredFunctions = []
    this

  Operation::resolve = (err, res) ->
    i = undefined
    iE = undefined
    unless err
      @_resolved = 1
      @_result = res
      i = 0
      while i < @_callbacks.length
        @_callbacks[i] res
        ++i
    else
      @_resolved = 2
      @_result = err
      iE = 0
      while iE < @_errCallbacks.length
        @_errCallbacks[iE] res
        ++iE
    @_callbacks = []
    @_errCallbacks = []
    return

  Operation::then = (cb, errCb) ->
    if @_resolved is 1
      cb @_result  if cb
      return
    else if @_resolved is 2
      errCb @_result  if errCb
      return
    @_callbacks[@_callbacks.length] = cb  if cb
    @_errCallbacks[@_errCallbacks.length] = errCb  if errCb
    this


  Parallel.isSupported = ->
    _supports

  Parallel::getWorkerSource = (cb) ->
    preStr = ""
    i = 0
    preStr += "importScripts(\"" + @requiredScripts.join("\",\"") + "\");\r\n"  if not isNode and @requiredScripts.length isnt 0
    i = 0
    while i < @requiredFunctions.length
      if @requiredFunctions[i].name
        preStr += "var " + @requiredFunctions[i].name + " = " + @requiredFunctions[i].fn.toString() + ";"
      else
        preStr += @requiredFunctions[i].fn.toString()
      ++i
    if isNode
      preStr + "process.on(\"message\", function(e) {process.send(JSON.stringify((" + cb.toString() + ")(JSON.parse(e).data)))})"
    else
      preStr + "self.onmessage = function(e) {self.postMessage((" + cb.toString() + ")(e.data))}"

  Parallel::require = ->
    args = Array::slice.call(arguments_, 0)
    i = 0
    while i < args.length
      func = args[i]
      if typeof func is "string"
        @requiredScripts.push func
      else if typeof func is "function"
        @requiredFunctions.push fn: func
      else
        @requiredFunctions.push func  if typeof func is "object"
      i++
    this

  Parallel::_spawnWorker = (cb) ->
    src = @getWorkerSource(cb)
    if isNode
      wrk = new Worker(@options.evalPath)
      wrk.postMessage src
    else
      return `undefined`  if Worker is `undefined`
      try
        if @requiredScripts.length isnt 0
          if @options.evalPath isnt null
            wrk = new Worker(@options.evalPath)
            wrk.postMessage src
          else
            throw new Error("Can't use required scripts without eval.js!")
        else unless URL
          throw new Error("Can't create a blob URL in this browser!")
        else
          blob = new Blob([src],
            type: "text/javascript"
          )
          url = URL.createObjectURL(blob)
          wrk = new Worker(url)
      catch e
        if @options.evalPath isnt null
          wrk = new Worker(@options.evalPath)
          wrk.postMessage src
        else
          throw e
    wrk

  Parallel::spawn = (cb) ->
    that = this
    newOp = new Operation()
    @operation.then ->
      wrk = undefined
      wrk = that._spawnWorker(cb)
      if wrk isnt `undefined`
        wrk.onmessage = (msg) ->
          wrk.terminate()
          that.data = msg.data
          newOp.resolve null, that.data

        wrk.postMessage that.data
      else if that.options.synchronous
        setImmediate ->
          that.data = cb(that.data)
          newOp.resolve null, that.data

      else
        throw new Error("Workers do not exist and synchronous operation not allowed!")

    @operation = newOp
    this

  Parallel::_spawnMapWorker = (i, cb, done) ->
    that = this
    wrk = that._spawnWorker(cb)
    if wrk isnt `undefined`
      wrk.onmessage = (msg) ->
        wrk.terminate()
        that.data[i] = msg.data
        done()

      wrk.postMessage that.data[i]
    else if that.options.synchronous
      setImmediate ->
        that.data[i] = cb(that.data[i])
        done()

    else
      throw new Error("Workers do not exist and synchronous operation not allowed!")

    return

  Parallel::map = (cb) ->
    done = ->
      if ++doneOps is that.data.length
        newOp.resolve null, that.data
      else
        that._spawnMapWorker startedOps++, cb, done  if startedOps < that.data.length

    return @spawn(cb)  unless @data.length
    that = this
    startedOps = 0
    doneOps = 0
    newOp = new Operation()
    @operation.then ->
      _results = undefined
      _results = []
      while startedOps - doneOps < that.options.maxWorkers and startedOps < that.data.length
        that._spawnMapWorker startedOps, cb, done
        _results.push ++startedOps
      _results

    @operation = newOp
    this

  Parallel::_spawnReduceWorker = (data, cb, done) ->
    that = this
    wrk = that._spawnWorker(cb)
    if wrk isnt `undefined`
      wrk.onmessage = (msg) ->
        wrk.terminate()
        that.data[that.data.length] = msg.data
        done()

      wrk.postMessage data
    else if that.options.synchronous
      setImmediate ->
        that.data[that.data.length] = cb(data)
        done()

    else
      throw new Error("Workers do not exist and synchronous operation not allowed!")
    return

  Parallel::reduce = (cb) ->
    done = (data) ->
      --runningWorkers
      if that.data.length is 1 and runningWorkers is 0
        that.data = that.data[0]
        newOp.resolve null, that.data
      else if that.data.length > 1
        ++runningWorkers
        that._spawnReduceWorker [that.data[0], that.data[1]], cb, done
        that.data.splice 0, 2

    throw new Error("Can't reduce non-array data")  unless @data.length
    runningWorkers = 0
    that = this
    newOp = new Operation()
    @operation.then ->
      i = undefined
      if that.data.length is 1
        newOp.resolve null, that.data[0]
      else
        i = 0
        while i < that.options.maxWorkers and i < Math.floor(that.data.length / 2)
          ++runningWorkers
          that._spawnReduceWorker [that.data[i * 2], that.data[i * 2 + 1]], cb, done
          ++i
        that.data.splice 0, i * 2

    @operation = newOp
    this

  Parallel::then = (cb, errCb) ->
    that = this
    newOp = new Operation()
    @operation.then (->
      retData = undefined
      retData = cb(that.data)
      that.data = retData  if retData isnt `undefined`
      newOp.resolve null, that.data
    ), errCb
    @operation = newOp
    this

  if isNode
    module.exports = Parallel
    @Parallel = Parallel
  else
    self.Parallel = Parallel


# ------------------------------------------------- #
# ------------------------------------------------- #
# ------------------------------------------------- #

main()
  

