local status, illuminate = pcall(require, 'illuminate')
if (not status) then return end

illuminate.configure({
  filetypes_denylist = {
    'NvimTree'
  }
})
