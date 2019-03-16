load 'libs/bats-support/load'
load 'libs/bats-assert-1/load'

load helpers/test

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

@test "Printing out DEBUG message" {
  ./shwain DEBUG "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stdout_log_level "debug"
}

@test "Printing out INFO message" {
  ./shwain INFO "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stdout_log_level "info"
}

@test "Printing out EVENT message" {
  ./shwain EVENT "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stdout_log_level "event"
}

@test "Printing out WARN message" {
  ./shwain WARN "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stderr_log_level "warn"
}

@test "Printing out WARNING message" {
  ./shwain WARNING "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stderr_log_level "warning"
}

@test "Printing out ERROR message" {
  ./shwain ERROR "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stderr_log_level "error"
}

@test "Printing out CRITICAL message" {
  ./shwain CRITICAL "$SIMPLE_TEST_MESSAGE" 1>${STDOUT_PATH} 2>${STDERR_PATH}
  test.stderr_log_level "critical"
}


@test "Test JSON output" {
  run ./shwain -j INFO "Message" key1=value1 key2=value2
  test.json_output
}

@test "Test JSON output even if --simple flag is provided" {
  run ./shwain -j --simple INFO "Message"
  test.json_simple_output
}

@test "Test simple output" {
  run ./shwain --simple INFO "Message"
  test.simple_output
}

@test "Test enriched JSON output" {
  run ./shwain -j --enrich ERROR "Message"
  test.enriched_json_output
}

@test "Test enriched non-JSON output" {
  run ./shwain --enrich EVENT "Message"
  test.enriched_non_json_output
}

@test "Test additional fields" {
  run ./shwain CRITICAL "Message" X=Y a=b
  test.additional_fields
}
