GLOBAL_STARTUP_TIMESTAMP = GLOBAL_STARTUP_TIMESTAMP or os.time()

daily_tasks = daily_tasks or {
    brackets = {
        [1] = { 
            min_rebirth = 0, 
            max_rebirth = 24, 
            monsters = { "Mutated Human" ,"Brimstone Bug", "Crocodile", "Mutated Bat" },
             required_kills = 750, 
             reward_func = function(player) 
                player:doReborn(1) 
				return "1 reborn"
            end 
        },
		
		[2] = { 
            min_rebirth = 25, 
            max_rebirth = 49, 
            monsters = { "Minishabaal", "Undead Gladiator", "Frost Troll", "Warlock" },
             required_kills = 750, 
             reward_func = function(player) 
                player:doReborn(1) 
				return "1 reborn"
            end 
        },
		
		[3] = { 
            min_rebirth = 50, 
            max_rebirth = 99, 
            monsters = { "Tortoise", "Undead Dragon", "Snake God Essence", "Hydra", "Crystalcrusher" },
             required_kills = 750, 
             reward_func = function(player) 
                player:addLevel(500000) 
				return "500k level"
            end 
        },
		
		[4] = { 
            min_rebirth = 100, 
            max_rebirth = 149, 
            monsters = { "Grim Reaper", "Mawhawk", "Blue Djinn", "Green Djinn", "Wiggler" },
             required_kills = 750, 
             reward_func = function(player) 
                player:addLevel(400000) 
				return "400k level"
            end 
        },
		
		[5] = { 
            min_rebirth = 150, 
            max_rebirth = 199, 
            monsters = { "Lost Berserker", "Clif Stirder", "Orewalker", "Ironblight", "Ice Morgaroth", "Ghastly Dragon", "Blightwalker" },
             required_kills = 250, 
             reward_func = function(player) 
                player:addLevel(350000) 
				return "350k level"
            end 
        },
		
		[6] = { 
            min_rebirth = 200, 
            max_rebirth = 299, 
            monsters = { "Forgotten Hydra", "Forgotten Dark Hydra", "Alpha Orcion", "Beta Orcion", "Delta Orcion", "Hideous Fungus", "Humongous Fungus" },
             required_kills = 1000, 
             reward_func = function(player) 
                player:addLevel(300000) 
				return "300k level"
            end 
        },
		
		[7] = { 
            min_rebirth = 300, 
            max_rebirth = 700, 
            monsters = { "Guzzlemaw", "Frazzlemaw", "Silencer"},
             required_kills = 750, 
             reward_func = function(player) 
                player:addLevel(300000) 
				return "300k level"
            end 
        },

    },
    storage = {}
}