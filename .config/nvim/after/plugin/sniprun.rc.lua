local status, sniprun = pcall(require, "sniprun")
if (not status) then return end

sniprun.setup({
  display = {
    'TempFloatingWindow',
  }
})
