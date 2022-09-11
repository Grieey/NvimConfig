local present, null_ls = pcall(require, "null-ls")

if not present then
  print "null-ls not load success!"
  return
end

local b = null_ls.builtins
local sources = {
  -- web stuff
  b.formatting.deno_fmt,

  b.formatting.prettier.with { -- 只比默认配置少了 markdown
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "html",
      "json",
      "yaml",
      "graphql",
    },
    prefer_local = "node_modules/.bin",
  },
  -- toml
  b.formatting.taplo,
  -- dart
  b.formatting.dart_format,
  -- rust
  b.formatting.rustfmt,
  -- lua
  b.formatting.stylua,
  -- shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
