local _, addonTable = ...

function addonTable:GetOverrideResourceColor(resource)
    local color = addonTable:GetResourceColor(resource)

    local settings = SenseiClassResourceBarDB and SenseiClassResourceBarDB["_Settings"]
    local powerColors = settings and settings["PowerColors"]
    local overrideColor = powerColors and powerColors[resource]

    if overrideColor then
        if overrideColor.r then color.r = overrideColor.r end
        if overrideColor.g then color.g = overrideColor.g end
        if overrideColor.b then color.b = overrideColor.b end
        if overrideColor.a then color.a = overrideColor.a end
    end

    return color
end

function addonTable:GetResourceColor(resource)
    local color = nil

    local powerName = nil
    for name, value in pairs(Enum.PowerType) do
        if value == resource then
            -- LunarPower -> LUNAR_POWER
            powerName = name:gsub("(%u)", "_%1"):gsub("^_", ""):upper()
            break;
        end
    end

    if resource == "STAGGER" then
        color = GetPowerBarColor("STAGGER").green
    elseif resource == "SOUL_FRAGMENTS" then
        -- Different color during Void Metamorphosis
        if DemonHunterSoulFragmentsBar and DemonHunterSoulFragmentsBar.CollapsingStarBackground:IsShown() then
            color = { r = 0.037, g = 0.220, b = 0.566, atlas = "UF-DDH-CollapsingStar-Bar-Ready" }
        else 
            color = { r = 0.278, g = 0.125, b = 0.796, atlas = "UF-DDH-VoidMeta-Bar-Ready" }
        end
    elseif resource == Enum.PowerType.Runes then
        local spec = C_SpecializationInfo.GetSpecialization()
        local specID = C_SpecializationInfo.GetSpecializationInfo(spec)

        if specID == 250 then -- Blood
            color = { r = 1, g = 0.2, b = 0.3 }
        elseif specID == 251 then -- Frost
            color = { r = 0.0, g = 0.6, b = 1.0 }
        elseif specID == 252 then -- Unholy
            color = { r = 0.1, g = 1.0, b = 0.1 }
        end
        -- Else fallback on Blizzard Runes color, grey...
    elseif resource == Enum.PowerType.Essence then
        color = GetPowerBarColor("FUEL")
    elseif resource == Enum.PowerType.ComboPoints then
        color = { r = 0.878, g = 0.176, b = 0.180 }
    elseif resource == Enum.PowerType.Chi then
        color = { r = 0.024, g = 0.741, b = 0.784 }
    end

    -- If not custom, try with power name or id
    return CopyTable(color or GetPowerBarColor(powerName) or GetPowerBarColor(resource) or { r = 1, g = 1, b = 1 })
end