-- Pomodoro Setup
require('pomo').setup({
    update_interval = 1000,
    notifiers = {
    {
      name = "Default",
      opts = {
        sticky = true,
        title_icon = "󱎫",
        text_icon = "󰄉",
        -- Replace the above with these if you don't have a patched font:
        -- title_icon = "⏳",
        -- text_icon = "⏱️",
      },
      { name = "System" },
    },
    timers = {
        Break = {
            { name = "System" },
        },
    },
  sessions = {
    pomodoro = {
      { name = "Work", duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work", duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work", duration = "25m" },
      { name = "Long Break", duration = "15m" },
    },
  },
  },
})
