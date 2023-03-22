if not IsDuplicityVersion() then
    local OGTaskPlayAnim = TaskPlayAnim
 
    TaskPlayAnim = function(a, animDict, animName, d, e, f, flag, h, i, j, k)
       OGTaskPlayAnim(a, animDict, animName, d, e, f, flag, h, i, j, k)
       TriggerEvent('rcore_cam:TaskPlayAnim', {a, animDict, animName, d, e, f, flag, h, i, j, k})
    end
 end