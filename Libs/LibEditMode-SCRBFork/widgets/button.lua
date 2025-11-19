local MINOR = 11
local lib, minor = LibStub('LibEditMode-SCRBFork')
if minor > MINOR then
	return
end

lib.internal:CreatePool('button', function()
	return CreateFrame('Button', nil, UIParent, 'EditModeSystemSettingsDialogExtraButtonTemplate')
end, function(_, frame)
	frame:Hide()
	frame.layoutIndex = nil
end)
