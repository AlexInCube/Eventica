level = 0
experience = 0
experienceToLevelUp = 5

EVENTICA_HANDLER.on("mobKilled", function(){
    AddExp(1)
})

function AddExp(_exp){
    experience += _exp
    if (experience >= experienceToLevelUp){
        level++
        experience = 0
    }
}