local M = {}

function M.tbl_unique(list)
  local seen = {}
  local out = {}
  if not list then
    return out
  end
  for _, v in ipairs(list) do
    if not seen[v] then
      seen[v] = true
      out[#out + 1] = v
    end
  end
  return out
end

return M
