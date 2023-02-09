local setup = function()
    local optimise = require'optimise'

    optimise.skip_providers()
    optimise.disable_distribution_plugins()
    require'utils'
    require'keys'.setup()
    require'settings'.setup()
    require'plugins'
end

setup()
