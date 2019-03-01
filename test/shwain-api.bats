load 'libs/bats-support/load'
load 'libs/bats-assert-1/load'

@test "Printing out INFO message" {
  source ./shwain
  run log.info "Simple Message"
  assert_output -p "INFO"
  assert_output -p "Simple Message"
}

@test "Printing out DEBUG message" {
  source ./shwain
  run log.debug "Simple Message"
  assert_output -p "DEBUG"
  assert_output -p "Simple Message"
}

@test "Printing out CRITICAL message" {
  source ./shwain
  run log.critical "Simple Message"
  assert_output -p "CRITICAL"
  assert_output -p "Simple Message"
}

@test "Printing out WARN message" {
  source ./shwain
  run log.warning "Simple Message"
  assert_output -p "WARN"
  assert_output -p "Simple Message"
}

@test "Printing out WARN message" {
  source ./shwain
  run log.warn "Simple Message"
  assert_output -p "WARN"
  assert_output -p "Simple Message"
}

@test "Printing out EVENT message" {
  source ./shwain
  run log.event "Simple Message"
  assert_output -p "EVENT"
  assert_output -p "Simple Message"
}

@test "Printing out ERROR message" {
  source ./shwain
  run log.error "Simple Message"
  assert_output -p "ERROR"
  assert_output -p "Simple Message"
}

@test "Test JSON output" {
  source ./shwain
  export SHWAIN_JSON=true
  run log.info "Message" key1=value1 key2=value2
  echo $output
  assert [ $(echo $output | jq .name) == "\"SHWAIN\"" ]
  assert [ $(echo $output | jq .level) == "\"INFO\"" ]
  assert [ $(echo $output | jq .message) == "\"Message\"" ]
  assert [ $(echo $output | jq .key1) == "\"value1\"" ]
  assert [ $(echo $output | jq .key2) == "\"value2\"" ]
}

@test "Test JSON output even if --simple flag is provided" {
  source ./shwain
  export SHWAIN_JSON=true
  export SHWAIN_SIMPLE=true
  run log.info "Message"
  assert [ $(echo $output | jq .name) == "\"SHWAIN\"" ]
}

@test "Test simple output" {
  source ./shwain
  export SHWAIN_SIMPLE=true
  run log.info "Message"
  refute_output "INFO"
  # For some reason, asserting without -p doesn't succeed here.
  assert_output -p "Message"
}

@test "Test enriched JSON output" {
  source ./shwain
  export SHWAIN_JSON=true
  export SHWAIN_ENRICH=true
  run log.error "Message"
  assert [ $(echo $output | jq .name) == "\"SHWAIN\"" ]
  assert [ $(echo $output | jq .level) == "\"ERROR\"" ]
  assert [ $(echo $output | jq .message) == "\"Message\"" ]
  assert [ $(echo $output | jq .type) == "\"log\"" ]
  assert echo $output | jq -e .timestamp
  assert echo $output | jq -e .hostname
  assert echo $output | jq -e .pid
}

@test "Test enriched non-JSON output" {
  source ./shwain
  export SHWAIN_ENRICH=true
  run log.event "Message"
  assert [ "$status" -eq 0 ]
  assert_output -p "pid="
  assert_output -p "hostname="
  assert_output -p "type=event"
}

@test "Test additional fields" {
  source ./shwain
  run log.critical "Message" X=Y a=b
  assert [ "$status" -eq 0 ]
  assert_output -p "X=Y"
  assert_output -p "a=b"
}
