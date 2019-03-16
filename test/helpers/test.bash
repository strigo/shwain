readonly STDOUT_PATH="${BATS_TMPDIR}/bats_test_${BATS_TEST_NAME}.stdout"
readonly STDERR_PATH="${BATS_TMPDIR}/bats_test_${BATS_TEST_NAME}.stderr"

SIMPLE_TEST_MESSAGE="Simple Message"

function teardown() {
  rm -f "$BATS_TMPDIR/bats_test.*"
}

function test.stdout_log_level() {
  local level="$1"

  assert [ "$?" -eq 0 ]

  grep "${level^^}"  ${STDOUT_PATH}
  grep "$SIMPLE_TEST_MESSAGE"  ${STDOUT_PATH}
  ! grep "${level^^}"  ${STDERR_PATH}
}

function test.stderr_log_level() {
  local level="$1"
  local message="$2"

  assert [ "$?" -eq 0 ]

  ! grep "${level^^}"  ${STDOUT_PATH}
  grep "${level^^}"  ${STDERR_PATH}
  grep "$SIMPLE_TEST_MESSAGE"  ${STDERR_PATH}
}

function test.enriched_json_output() {
  assert [ "$status" -eq 0 ]
  assert [ $(echo $output | jq .name) == "\"SHWAIN\"" ]
  assert [ $(echo $output | jq .level) == "\"ERROR\"" ]
  assert [ $(echo $output | jq .message) == "\"Message\"" ]
  assert [ $(echo $output | jq .type) == "\"log\"" ]
  assert echo $output | jq -e .timestamp
  assert echo $output | jq -e .hostname
  assert echo $output | jq -e .pid
}

function test.json_output() {
  assert [ "$status" -eq 0 ]
  assert [ $(echo $output | jq .name) == "\"SHWAIN\"" ]
  assert [ $(echo $output | jq .level) == "\"INFO\"" ]
  assert [ $(echo $output | jq .message) == "\"Message\"" ]
  assert [ $(echo $output | jq .key1) == "\"value1\"" ]
  assert [ $(echo $output | jq .key2) == "\"value2\"" ]
}

function test.json_simple_output() {
  assert [ "$status" -eq 0 ]
  assert [ $(echo $output | jq .name) == "\"SHWAIN\"" ]
}

function test.simple_output() {
  assert [ "$status" -eq 0 ]
  refute_output "INFO"
  # For some reason, asserting without -p doesn't succeed here. Probably some hidden char.
  assert_output -p "Message"
}

function test.enriched_non_json_output() {
  assert [ "$status" -eq 0 ]
  assert_output -p "pid="
  assert_output -p "hostname="
  assert_output -p "type=event"
}

function test.additional_fields() {
  assert [ "$status" -eq 0 ]
  assert_output -p "X=Y"
  assert_output -p "a=b"
}
