function hitLightingAnim(hit)
  if hit=="MAX" then
    hitLightingColour.r=1
    hitLightingColour.g=1
    hitLightingColour.b=1
  elseif hit=="Perfect" then
    hitLightingColour.r=1
    hitLightingColour.g=224/255
    hitLightingColour.b=23/255
  elseif hit=="Great" then
    hitLightingColour.r=14/255
    hitLightingColour.g=235/255
    hitLightingColour.b=0/255
  elseif hit=="Good" then
    hitLightingColour.r=0
    hitLightingColour.g=128/255
    hitLightingColour.b=1
  elseif hit=="OK" then
    hitLightingColour.r=174/255
    hitLightingColour.g=0
    hitLightingColour.b=1
  elseif hit=="Miss" then
    hitLightingColour.r=1
    hitLightingColour.g=0
    hitLightingColour.b=0
  end
  return hitLightingColour
end
function masterHit(direction)
  if direction=="l" then
  end
end