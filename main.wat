(module
  (import "wasi_snapshot_preview1" "proc_exit" (func (param i32)))
  (func
    i32.const 42
    call 0
    unreachable)
  (memory (export "memory") 0)
  (export "_start" (func 1)))
