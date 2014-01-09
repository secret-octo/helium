
/**
  * better YUI doc here:
  * poker engine prototype
  * also included in this pen is my fork of paralleljs
  */
;

/*
  * better YUI doc here:
  * main function. The one to be run at the end of the script.
  */
;
var handEval, main;

main = function() {
  var p;
  p = new Parallel();
  p.spawn(handEval);
  p.then(function(data) {
    return document.getElementById('output').innerHTML = JSON.parse(data).innerHTML.replace(/\n/g, '<br\>');
  });
  console.log("------------------------");
  return console.log("returned promise");
};


/**
  * better YUI doc here:
  * this method runs inside a webworker
  * or fork child_process on nodejs
  */
;

handEval = function() {
  var A, J, K, Q, T, counter, date, get5cardScore, getTypeDetail, h01, h02, h03, h04, h05, h06, h07, h08, h09, h10, h11, h12, h13, h14, h15, h16, h17, h18, h19, h20, names, output, _;
  output = {
    innerHTML: ""
  };
  names = [0, 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"];
  A = 14;
  K = 13;
  Q = 12;
  J = 11;
  T = 10;
  _ = {
    "♠": 1,
    "♣": 2,
    "♥": 4,
    "♦": 8
  };
  get5cardScore = function(cs, ss) {
    var c, d, i, o, s, v;
    d = {};
    s = 1 << cs[0] | 1 << cs[1] | 1 << cs[2] | 1 << cs[3] | 1 << cs[4];
    i = v = o = 0;
    while (i < 5) {
      o = Math.pow(2, cs[i] * 4);
      v += o * (d[cs[i]] = (v / o & 15) + 1);
      i++;
    }
    v = v % 15 - ((s / (s & -s) === 31) || (s === 0x403c) ? 3 : 1) - (ss[0] === (ss[1] | ss[2] | ss[3] | ss[4])) * (s === 0x7c00 ? -5 : 1);
    c = s === 0x403c ? [5, 4, 3, 2, 1] : cs.slice().sort(function(a, b) {
      if (d[a] < d[b]) {
        return 1;
      } else {
        if (d[a] > d[b]) {
          return -1;
        } else {
          return b - a;
        }
      }
    });
    return [7, 8, 4, 5, 0, 1, 2, 9, 3, 6][v] << 20 | c[0] << 16 | c[1] << 12 | c[2] << 8 | c[3] << 4 | c[4];
  };
  getTypeDetail = function(x) {
    var c1, c2, c3, c4, cat;
    cat = x >> 20;
    c1 = x >> 16 & 15;
    c2 = x >> 12 & 15;
    c3 = x >> 8 & 15;
    c4 = x >> 4 & 15;
    console.log("" + x + " -- " + cat + " -- 1: " + c1 + " -- 2: " + c2 + " -- 3: " + c3 + " -- 4: " + c4);
    switch (cat) {
      case 0:
        return names[c1] + " high";
      case 1:
        return "Pair of " + names[c1] + "s";
      case 2:
        return "Two pair, " + names[c1] + "s and " + names[c3] + "s";
      case 3:
        return "Three of a kind, " + names[c1] + "s";
      case 4:
        return names[c1] + " high straight";
      case 5:
        return names[c1] + " high flush";
      case 6:
        return names[c1] + "s full of " + names[c4] + "s";
      case 7:
        return "Four of a kind, " + names[c1] + "s";
      case 8:
        return names[c1] + " high straight flush";
      case 9:
        return "Royal flush";
    }
  };
  date = new Date().getTime();
  counter = 0;
  while ((date + 1000 * 2) > new Date().getTime()) {
    h01 = get5cardScore([T, J, Q, K, A], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]]);
    h02 = get5cardScore([T, J, Q, K, 9], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]]);
    h03 = get5cardScore([2, 3, 4, 5, A], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]]);
    h04 = get5cardScore([8, 8, 8, 8, 9], [_["♠"], _["♣"], _["♥"], _["♦"], _["♠"]]);
    h05 = get5cardScore([A, A, A, 9, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
    h06 = get5cardScore([T, J, 6, K, 9], [_["♣"], _["♣"], _["♣"], _["♣"], _["♣"]]);
    h07 = get5cardScore([T, J, Q, 8, 9], [_["♠"], _["♣"], _["♥"], _["♣"], _["♦"]]);
    h08 = get5cardScore([2, 3, 4, 5, A], [_["♠"], _["♣"], _["♥"], _["♣"], _["♦"]]);
    h09 = get5cardScore([4, 4, 4, 8, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
    h10 = get5cardScore([7, 7, J, 9, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
    h11 = get5cardScore([6, 6, 3, 5, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
    h12 = get5cardScore([T, 5, 4, 7, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
    h13 = get5cardScore([A, A, A, 8, 8], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
    h14 = get5cardScore([T, J, 9, K, Q], [_["♣"], _["♣"], _["♣"], _["♣"], _["♣"]]);
    h15 = get5cardScore([3, 5, 4, 2, 6], [_["♠"], _["♣"], _["♥"], _["♦"], _["♣"]]);
    h16 = get5cardScore([3, 5, 4, 2, 6], [_["♥"], _["♣"], _["♠"], _["♦"], _["♠"]]);
    h17 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♣"], _["♠"], _["♦"], _["♠"]]);
    h18 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♣"], _["♥"], _["♣"]]);
    h19 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♥"], _["♥"], _["♣"]]);
    h20 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♥"], _["♥"], _["♥"]]);
    counter += 20;
  }
  output.innerHTML = "total hands evaluated: " + counter + ", avg hand/milisec: " + (counter / ((new Date().getTime()) - date)) + "\n";
  h01 = get5cardScore([T, J, Q, K, A], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]]);
  h02 = get5cardScore([J, Q, T, K, 9], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]]);
  h03 = get5cardScore([2, 5, 3, 4, A], [_["♠"], _["♠"], _["♠"], _["♠"], _["♠"]]);
  h04 = get5cardScore([A, A, A, A, K], [_["♠"], _["♣"], _["♥"], _["♦"], _["♠"]]);
  h05 = get5cardScore([A, A, A, 9, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
  h06 = get5cardScore([T, J, 6, K, 9], [_["♣"], _["♣"], _["♣"], _["♣"], _["♣"]]);
  h07 = get5cardScore([T, J, Q, 8, 9], [_["♠"], _["♣"], _["♥"], _["♣"], _["♦"]]);
  h08 = get5cardScore([2, 3, 4, 5, A], [_["♠"], _["♣"], _["♥"], _["♣"], _["♦"]]);
  h09 = get5cardScore([4, 4, 4, 8, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
  h10 = get5cardScore([7, 7, J, 9, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
  h11 = get5cardScore([6, 6, 3, 5, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
  h12 = get5cardScore([T, 5, 4, 7, 9], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
  h13 = get5cardScore([A, A, A, 8, 8], [_["♠"], _["♣"], _["♥"], _["♠"], _["♣"]]);
  h14 = get5cardScore([T, J, 9, K, Q], [_["♣"], _["♣"], _["♣"], _["♣"], _["♣"]]);
  h15 = get5cardScore([3, 5, 4, 2, 8], [_["♠"], _["♣"], _["♥"], _["♦"], _["♣"]]);
  h16 = get5cardScore([3, 5, 4, 2, 7], [_["♥"], _["♣"], _["♠"], _["♦"], _["♠"]]);
  h17 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♣"], _["♠"], _["♦"], _["♠"]]);
  h18 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♣"], _["♥"], _["♣"]]);
  h19 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♥"], _["♥"], _["♣"]]);
  h20 = get5cardScore([A, K, Q, T, 9], [_["♥"], _["♥"], _["♥"], _["♥"], _["♥"]]);
  output.innerHTML += "\ncomparing a few hands:\n";
  output.innerHTML += "====================\n";
  output.innerHTML += "T♠ J♠ Q♠ K♠ A♠ > J♠ Q♠ T♠ K♠ 9♠ -- " + (h01 > h02) + "\n";
  output.innerHTML += "2♠ 5♠ 3♠ 4♠ A♠ > J♠ Q♠ T♠ K♠ 9♠ -- " + (h03 > h02) + "\n";
  output.innerHTML += "A♠ A♣ A♥ 8♠ 8♣ > A♠ A♣ A♥ 9♦ 9♣ -- " + (h13 > h05) + "\n";
  output.innerHTML += "2♠ 5♠ 3♠ 4♠ A♠ > A♠ A♣ A♥ A♦ K♠ -- " + (h03 > h04) + "\n";
  output.innerHTML += "T♣ J♣ 6♣ K♣ 9♣ > J♠ Q♠ T♠ K♠ 9♠ -- " + (h06 > h02) + "\n";
  output.innerHTML += "T♣ J♣ 9♣ K♣ Q♣ = J♠ Q♠ T♠ K♠ 9♠ -- " + (h14 === h02) + "\n";
  output.innerHTML += "\ntesting hand categorization and score:\n";
  output.innerHTML += "=========================\n";
  output.innerHTML += "01: T♠ J♠ Q♠ K♠ A♠ -- " + getTypeDetail(h01) + (" -- " + h01 + "\n");
  output.innerHTML += "02: T♠ J♠ Q♠ K♠ 9♠ -- " + getTypeDetail(h02) + (" -- " + h02 + "\n");
  output.innerHTML += "03: 2♠ 3♠ 4♠ 5♠ A♠ -- " + getTypeDetail(h03) + (" -- " + h03 + "\n");
  output.innerHTML += "04: 8♠ 8♣ 8♥ 8♦ 9♦ -- " + getTypeDetail(h04) + (" -- " + h04 + "\n");
  output.innerHTML += "05: A♠ A♣ A♥ 9♦ 9♣ -- " + getTypeDetail(h05) + (" -- " + h05 + "\n");
  output.innerHTML += "06: T♣ J♣ 6♣ K♣ 9♣ -- " + getTypeDetail(h06) + (" -- " + h06 + "\n");
  output.innerHTML += "07: T♠ J♣ Q♥ 8♣ 9♦ -- " + getTypeDetail(h07) + (" -- " + h07 + "\n");
  output.innerHTML += "08: 2♠ 3♣ 4♥ 5♦ A♦ -- " + getTypeDetail(h08) + (" -- " + h08 + "\n");
  output.innerHTML += "09: 4♠ 4♣ 4♥ 8♠ 9♣ -- " + getTypeDetail(h09) + (" -- " + h09 + "\n");
  output.innerHTML += "10: 7♠ 7♣ J♥ 9♠ 9♣ -- " + getTypeDetail(h10) + (" -- " + h10 + "\n");
  output.innerHTML += "11: 6♠ 6♣ 3♥ 5♠ 9♣ -- " + getTypeDetail(h11) + (" -- " + h11 + "\n");
  output.innerHTML += "12: T♠ 5♣ 4♥ 7♠ 9♣ -- " + getTypeDetail(h12) + (" -- " + h12 + "\n");
  output.innerHTML += "13: A♠ A♣ A♥ 8♠ 8♣ -- " + getTypeDetail(h13) + (" -- " + h13 + "\n");
  output.innerHTML += "14: T♣ J♣ 9♣ K♣ Q♣ -- " + getTypeDetail(h14) + (" -- " + h14 + "\n");
  output.innerHTML += "15: 3♠ 5♣ 4♠ 2♥ 8♣ -- " + getTypeDetail(h15) + (" -- " + h15 + "\n");
  output.innerHTML += "16: 3♥ 5♣ 4♠ 2♦ 7♠ -- " + getTypeDetail(h16) + (" -- " + h16 + "\n");
  output.innerHTML += "17: A♥ K♣ Q♠ T♠ 9♠ -- " + getTypeDetail(h17) + (" -- " + h17 + "\n");
  output.innerHTML += "18: A♥ K♥ Q♣ T♥ 9♣ -- " + getTypeDetail(h18) + (" -- " + h18 + "\n");
  output.innerHTML += "19: A♥ K♥ Q♥ T♥ 9♣ -- " + getTypeDetail(h19) + (" -- " + h10 + "\n");
  output.innerHTML += "20: A♥ K♥ Q♥ T♥ 9♥ -- " + getTypeDetail(h20) + (" -- " + h20 + "\n");
  return JSON.stringify(output);
};


/**
  * some YUI doc here:
  * the parallel fork in coffee-script
  * the eval.js and worker.js are missing. But its ok because it isn't
  * needed to work on browser. (but ie-10 may have problems, as usual)
  */
;

(function() {
  var Operation, Parallel, URL, Worker, defaults, extend, isNode, setImmediate, _supports;
  isNode = typeof global !== "undefined" && {}.toString.call(global) === "[object global]";
  setImmediate = setImmediate || function(cb) {
    return setTimeout(cb, 0);
  };
  defaults = {
    evalPath: (isNode ? __dirname + "/parallel/eval.js" : null),
    maxWorkers: (isNode ? require("os").cpus().length : 4),
    synchronous: true
  };
  Worker = (isNode ? require(__dirname + "/parallel/Worker.js") : self.Worker);
  URL = (typeof self !== "undefined" ? (self.URL ? self.URL : self.webkitURL) : null);
  _supports = (isNode || self.Worker ? true : false);
  extend = function(from, to) {
    var i;
    i = void 0;
    if (!to) {
      to = {};
    }
    for (i in from) {
      if (to[i] === undefined) {
        to[i] = from[i];
      }
    }
    return to;
  };
  Operation = function() {
    this._callbacks = [];
    this._errCallbacks = [];
    this._resolved = 0;
    this._result = null;
  };
  Parallel = function(data, options) {
    this.data = data;
    this.options = extend(defaults, options);
    this.operation = new Operation();
    this.operation.resolve(null, this.data);
    this.requiredScripts = [];
    this.requiredFunctions = [];
    return this;
  };
  Operation.prototype.resolve = function(err, res) {
    var i, iE;
    i = void 0;
    iE = void 0;
    if (!err) {
      this._resolved = 1;
      this._result = res;
      i = 0;
      while (i < this._callbacks.length) {
        this._callbacks[i](res);
        ++i;
      }
    } else {
      this._resolved = 2;
      this._result = err;
      iE = 0;
      while (iE < this._errCallbacks.length) {
        this._errCallbacks[iE](res);
        ++iE;
      }
    }
    this._callbacks = [];
    this._errCallbacks = [];
  };
  Operation.prototype.then = function(cb, errCb) {
    if (this._resolved === 1) {
      if (cb) {
        cb(this._result);
      }
      return;
    } else if (this._resolved === 2) {
      if (errCb) {
        errCb(this._result);
      }
      return;
    }
    if (cb) {
      this._callbacks[this._callbacks.length] = cb;
    }
    if (errCb) {
      this._errCallbacks[this._errCallbacks.length] = errCb;
    }
    return this;
  };
  Parallel.isSupported = function() {
    return _supports;
  };
  Parallel.prototype.getWorkerSource = function(cb) {
    var i, preStr;
    preStr = "";
    i = 0;
    if (!isNode && this.requiredScripts.length !== 0) {
      preStr += "importScripts(\"" + this.requiredScripts.join("\",\"") + "\");\r\n";
    }
    i = 0;
    while (i < this.requiredFunctions.length) {
      if (this.requiredFunctions[i].name) {
        preStr += "var " + this.requiredFunctions[i].name + " = " + this.requiredFunctions[i].fn.toString() + ";";
      } else {
        preStr += this.requiredFunctions[i].fn.toString();
      }
      ++i;
    }
    if (isNode) {
      return preStr + "process.on(\"message\", function(e) {process.send(JSON.stringify((" + cb.toString() + ")(JSON.parse(e).data)))})";
    } else {
      return preStr + "self.onmessage = function(e) {self.postMessage((" + cb.toString() + ")(e.data))}";
    }
  };
  Parallel.prototype.require = function() {
    var args, func, i;
    args = Array.prototype.slice.call(arguments_, 0);
    i = 0;
    while (i < args.length) {
      func = args[i];
      if (typeof func === "string") {
        this.requiredScripts.push(func);
      } else if (typeof func === "function") {
        this.requiredFunctions.push({
          fn: func
        });
      } else {
        if (typeof func === "object") {
          this.requiredFunctions.push(func);
        }
      }
      i++;
    }
    return this;
  };
  Parallel.prototype._spawnWorker = function(cb) {
    var blob, e, src, url, wrk;
    src = this.getWorkerSource(cb);
    if (isNode) {
      wrk = new Worker(this.options.evalPath);
      wrk.postMessage(src);
    } else {
      if (Worker === undefined) {
        return undefined;
      }
      try {
        if (this.requiredScripts.length !== 0) {
          if (this.options.evalPath !== null) {
            wrk = new Worker(this.options.evalPath);
            wrk.postMessage(src);
          } else {
            throw new Error("Can't use required scripts without eval.js!");
          }
        } else if (!URL) {
          throw new Error("Can't create a blob URL in this browser!");
        } else {
          blob = new Blob([src], {
            type: "text/javascript"
          });
          url = URL.createObjectURL(blob);
          wrk = new Worker(url);
        }
      } catch (_error) {
        e = _error;
        if (this.options.evalPath !== null) {
          wrk = new Worker(this.options.evalPath);
          wrk.postMessage(src);
        } else {
          throw e;
        }
      }
    }
    return wrk;
  };
  Parallel.prototype.spawn = function(cb) {
    var newOp, that;
    that = this;
    newOp = new Operation();
    this.operation.then(function() {
      var wrk;
      wrk = void 0;
      wrk = that._spawnWorker(cb);
      if (wrk !== undefined) {
        wrk.onmessage = function(msg) {
          wrk.terminate();
          that.data = msg.data;
          return newOp.resolve(null, that.data);
        };
        return wrk.postMessage(that.data);
      } else if (that.options.synchronous) {
        return setImmediate(function() {
          that.data = cb(that.data);
          return newOp.resolve(null, that.data);
        });
      } else {
        throw new Error("Workers do not exist and synchronous operation not allowed!");
      }
    });
    this.operation = newOp;
    return this;
  };
  Parallel.prototype._spawnMapWorker = function(i, cb, done) {
    var that, wrk;
    that = this;
    wrk = that._spawnWorker(cb);
    if (wrk !== undefined) {
      wrk.onmessage = function(msg) {
        wrk.terminate();
        that.data[i] = msg.data;
        return done();
      };
      wrk.postMessage(that.data[i]);
    } else if (that.options.synchronous) {
      setImmediate(function() {
        that.data[i] = cb(that.data[i]);
        return done();
      });
    } else {
      throw new Error("Workers do not exist and synchronous operation not allowed!");
    }
  };
  Parallel.prototype.map = function(cb) {
    var done, doneOps, newOp, startedOps, that;
    done = function() {
      if (++doneOps === that.data.length) {
        return newOp.resolve(null, that.data);
      } else {
        if (startedOps < that.data.length) {
          return that._spawnMapWorker(startedOps++, cb, done);
        }
      }
    };
    if (!this.data.length) {
      return this.spawn(cb);
    }
    that = this;
    startedOps = 0;
    doneOps = 0;
    newOp = new Operation();
    this.operation.then(function() {
      var _results;
      _results = void 0;
      _results = [];
      while (startedOps - doneOps < that.options.maxWorkers && startedOps < that.data.length) {
        that._spawnMapWorker(startedOps, cb, done);
        _results.push(++startedOps);
      }
      return _results;
    });
    this.operation = newOp;
    return this;
  };
  Parallel.prototype._spawnReduceWorker = function(data, cb, done) {
    var that, wrk;
    that = this;
    wrk = that._spawnWorker(cb);
    if (wrk !== undefined) {
      wrk.onmessage = function(msg) {
        wrk.terminate();
        that.data[that.data.length] = msg.data;
        return done();
      };
      wrk.postMessage(data);
    } else if (that.options.synchronous) {
      setImmediate(function() {
        that.data[that.data.length] = cb(data);
        return done();
      });
    } else {
      throw new Error("Workers do not exist and synchronous operation not allowed!");
    }
  };
  Parallel.prototype.reduce = function(cb) {
    var done, newOp, runningWorkers, that;
    done = function(data) {
      --runningWorkers;
      if (that.data.length === 1 && runningWorkers === 0) {
        that.data = that.data[0];
        return newOp.resolve(null, that.data);
      } else if (that.data.length > 1) {
        ++runningWorkers;
        that._spawnReduceWorker([that.data[0], that.data[1]], cb, done);
        return that.data.splice(0, 2);
      }
    };
    if (!this.data.length) {
      throw new Error("Can't reduce non-array data");
    }
    runningWorkers = 0;
    that = this;
    newOp = new Operation();
    this.operation.then(function() {
      var i;
      i = void 0;
      if (that.data.length === 1) {
        return newOp.resolve(null, that.data[0]);
      } else {
        i = 0;
        while (i < that.options.maxWorkers && i < Math.floor(that.data.length / 2)) {
          ++runningWorkers;
          that._spawnReduceWorker([that.data[i * 2], that.data[i * 2 + 1]], cb, done);
          ++i;
        }
        return that.data.splice(0, i * 2);
      }
    });
    this.operation = newOp;
    return this;
  };
  Parallel.prototype.then = function(cb, errCb) {
    var newOp, that;
    that = this;
    newOp = new Operation();
    this.operation.then((function() {
      var retData;
      retData = void 0;
      retData = cb(that.data);
      if (retData !== undefined) {
        that.data = retData;
      }
      return newOp.resolve(null, that.data);
    }), errCb);
    this.operation = newOp;
    return this;
  };
  if (isNode) {
    module.exports = Parallel;
    return this.Parallel = Parallel;
  } else {
    return self.Parallel = Parallel;
  }
})();

main();
