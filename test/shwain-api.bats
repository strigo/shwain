load 'libs/bats-support/load'
load 'libs/bats-assert-1/load'

load helpers/test

@test "Printing out DEBUG message" {
  source ./shwain
  log.debug "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stdout_log_level "debug"
}

@test "Printing out INFO message" {
  source ./shwain
  log.info "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stdout_log_level "info"
}

@test "Printing out EVENT message" {
  source ./shwain
  log.event "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stdout_log_level "event"
}

@test "Printing out WARN message" {
  source ./shwain
  log.warn "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stderr_log_level "warn"
}

@test "Printing out WARNING message" {
  source ./shwain
  log.warning "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stderr_log_level "warning"
}

@test "Printing out ERROR message" {
  source ./shwain
  log.error "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stderr_log_level "error"
}

@test "Printing out CRITICAL message" {
  source ./shwain
  log.critical "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stderr_log_level "critical"
}


@test "Test JSON output" {
  source ./shwain
  SHWAIN_JSON=true run log.info "Message" key1=value1 key2=value2
  test.json_output
}

@test "Test JSON output even if --simple flag is provided" {
  source ./shwain
  SHWAIN_JSON=true SHWAIN_SIMPLE=true run log.info "Message"
  test.json_simple_output
}

@test "Test simple output" {
  source ./shwain
  SHWAIN_SIMPLE=true run log.info "Message"
  test.simple_output
}

@test "Test enriched JSON output" {
  source ./shwain
  SHWAIN_JSON=true SHWAIN_ENRICH=true run log.error "Message"
  test.enriched_json_output
}

@test "Test enriched non-JSON output" {
  source ./shwain
  SHWAIN_ENRICH=true run log.event "Message"
  test.enriched_non_json_output
}

@test "Test additional fields" {
  source ./shwain
  run log.critical "Message" X=Y a=b
  test.additional_fields
}
