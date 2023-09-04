local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup {
  options = {
    mode = 'buffers',
    separator_style = 'slant',
    show_tab_indicators = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = true,
    tab_size = 0,
    max_name_length = 25,
    color_icons = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = " File Explorer",
        text_align = "left"
      }
    },
    modified_icon = '',
  },
  highlights = {
    separator = {
      fg = '#011627',
      bg = '#00111e',
    },
    separator_selected = {
      fg = '#011627',
      bg = '#073642',
    },
    separator_visible = {
      fg = '#011627',
      bg = '#073642',
    },
    buffer_selected = {
      bg = '#073642',
      bold = false,
      italic = false
    },
    buffer_visible = {
      bg = '#073642',
      bold = false,
      italic = false
    },
    modified = {
      bg = '#00111e',
      fg = '#479733',
    },
    modified_selected = {
      bg = '#073642',
      fg = '#56c73a',
    },
    duplicate = {
      bg = '#00111e',
    },
    duplicate_selected = {
      bg = '#073642',
    },
    background = {
      bg = '#00111e',
    },
  }
}
