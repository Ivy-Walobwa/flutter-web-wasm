(module
 (type $i32_=>_i32 (func (param i32) (result i32)))
 (memory $0 0)
 (export "plusOne" (func $assembly/index/plusOne))
 (export "minusOne" (func $assembly/index/minusOne))
 (export "memory" (memory $0))
 (func $assembly/index/plusOne (param $0 i32) (result i32)
  local.get $0
  i32.const 1
  i32.add
 )
 (func $assembly/index/minusOne (param $0 i32) (result i32)
  local.get $0
  i32.const 1
  i32.sub
 )
)
