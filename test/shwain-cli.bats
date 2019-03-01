load 'libs/bats-support/load'
load 'libs/bats-assert-1/load'

@test "Invoking shwain without arguments prints usage" {
  run ./shwain
  assert [ "$status" -eq 1 ]
  assert_output -p "shwain [OPTIONS] LEVEL MESSAGE [OBJECTS]"
}

@test "Invoking shwain with -h prints usage" {
  run ./shwain -h
  assert [ "$status" -eq 0 ]
  assert_output -p "shwain [OPTIONS] LEVEL MESSAGE [OBJECTS]"
}

@test "Printing out INFO message" {
  run ./shwain info "Simple Message"
  assert [ "$status" -eq 0 ]
  assert_output -p "INFO"
  assert_output -p "Simple Message"
}

@test "Printing out WARN message" {
  run ./shwain warn "Simple Message"
  assert [ "$status" -eq 0 ]
  assert_output -p "WARN"
  assert_output -p "Simple Message"
}

@test "Printing out DEBUG message" {
  run ./shwain DEBUG "Simple Message"
  assert [ "$status" -eq 0 ]
  assert_output -p "DEBUG"
  assert_output -p "Simple Message"
}

@test "Printing out ERROR message" {
  run ./shwain ERROR "Simple Message"
  assert [ "$status" -eq 0 ]
  assert_output -p "ERROR"
  assert_output -p "Simple Message"
}

@test "Printing out CRITICAL message" {
  run ./shwain CRITICAL "Simple Message"
  assert [ "$status" -eq 0 ]
  assert_output -p "CRITICAL"
  assert_output -p "Simple Message"
}

@test "Printing out WARNING message" {
  run ./shwain WARNING "Simple Message"
  assert [ "$status" -eq 0 ]
  assert_output -p "WARN"
  assert_output -p "Simple Message"
}

@test "Printing out EVENT message" {
  run ./shwain EVENT "Simple Message"
  assert [ "$status" -eq 0 ]
  assert_output -p "EVENT"
  assert_output -p "Simple Message"
}

@test "Test JSON output" {
  run ./shwain -j INFO "Message" key1=value1 key2=value2
  assert [ "$status" -eq 0 ]
  assert [ $(echo $output | jq .name) == "\"SHWAIN\"" ]
  assert [ $(echo $output | jq .level) == "\"INFO\"" ]
  assert [ $(echo $output | jq .message) == "\"Message\"" ]
  assert [ $(echo $output | jq .key1) == "\"value1\"" ]
  assert [ $(echo $output | jq .key2) == "\"value2\"" ]
}

@test "Test JSON output even if --simple flag is provided" {
  run ./shwain -j --simple INFO "Message"
  assert [ "$status" -eq 0 ]
  assert [ $(echo $output | jq .name) == "\"SHWAIN\"" ]
}

@test "Test simple output" {
  run ./shwain --simple INFO "Message"
  assert [ "$status" -eq 0 ]
  refute_output "INFO"
  # For some reason, asserting without -p doesn't succeed here.
  assert_output -p "Message"
}

@test "Test enriched JSON output" {
  run ./shwain -j --enrich ERROR "Message"
  assert [ "$status" -eq 0 ]
  assert [ $(echo $output | jq .name) == "\"SHWAIN\"" ]
  assert [ $(echo $output | jq .level) == "\"ERROR\"" ]
  assert [ $(echo $output | jq .message) == "\"Message\"" ]
  assert [ $(echo $output | jq .type) == "\"log\"" ]
  assert echo $output | jq -e .timestamp
  assert echo $output | jq -e .hostname
  assert echo $output | jq -e .pid
}

@test "Test enriched non-JSON output" {
  run ./shwain --enrich EVENT "Message"
  assert [ "$status" -eq 0 ]
  assert_output -p "pid="
  assert_output -p "hostname="
  assert_output -p "type=event"
}

@test "Test additional fields" {
  run ./shwain CRITICAL "Message" X=Y a=b
  assert [ "$status" -eq 0 ]
  assert_output -p "X=Y"
  assert_output -p "a=b"
}
