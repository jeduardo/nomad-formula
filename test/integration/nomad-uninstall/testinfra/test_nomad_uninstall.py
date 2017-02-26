def test_binary_absent(File):
    file = File('/usr/bin/nomad')
    assert not file.exists


def test_config_file_absent(File):
    file = File('/etc/nomad/nomad.hcl')
    assert not file.exists


def test_config_dir_absent(File):
    file = File('/etc/nomad')
    assert not file.exists


def test_data_dir_still_present(File):
    file = File('/var/lib/nomad')
    assert file.exists
    assert file.is_directory


def test_service_definition_removed(File):
    file = File('/etc/systemd/system/nomad.service')
    assert not file.exists


def test_service_is_not_running_and_disabled(Service):
    nomad = Service('nomad')
    assert not nomad.is_running
    assert not nomad.is_enabled
