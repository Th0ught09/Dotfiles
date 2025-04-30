return {
  "danymat/neogen",
  config = true,
  keys = {
    {
      "<leader>cg",
      function()
        require("neogen").generate({ type = "func" })
      end,
      desc = "Generate function docstring",
    },
  },
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}
