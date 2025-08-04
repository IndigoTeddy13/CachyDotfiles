rule = {
  matches = {
    {
      { "node.name", "matches", ".*" },
    },
  },
  apply_properties = {
    ["stream.restore-volume"] = true,
    ["stream.restore-mute"] = true,
  },
}

table.insert(alsa_monitor.rules, rule)
