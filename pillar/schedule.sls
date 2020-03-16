---

schedule:
  highstate:
    function: state.highstate
    minutes: 60
    splay: 3600
    run_on_start: True
