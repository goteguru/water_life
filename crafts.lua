

-- raw meat
minetest.register_craftitem("water_life:meat_raw", {
	description = ("Raw Meat"),
	inventory_image = "water_life_meat_raw.png",
	on_use = minetest.item_eat(3),
	groups = {food_meat_raw = 1, flammable = 2}
})

-- cooked meat
minetest.register_craftitem("water_life:meat", {
	description = ("Meat"),
	inventory_image = "water_life_meat.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, flammable = 2}
})

minetest.register_craft({
	type = "cooking",
	output = "water_life:meat",
	recipe = "water_life:meat_raw",
	cooktime = 5
})

-- lasso
minetest.register_tool("water_life:lasso", {
	description = ("Lasso (right-click animal to capture it)"),
	inventory_image = "water_life_lasso.png",
	groups = {flammable = 2}
})

if minetest.get_modpath("farming") then
	minetest.register_craft({
		output = "water_life:lasso",
		recipe = {
			{"farming:string", "", "farming:string"},
			{"", "default:diamond", ""},
			{"farming:string", "", "farming:string"}
		}
	})
end

minetest.register_alias("mobs:magic_lasso", "water_life:lasso")

minetest.register_craftitem("water_life:riverfish", {
	description = ("Riverfish"),
	inventory_image = "water_life_riverfish_item.png",
    wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    stack_max = 10,
    liquids_pointable = false,
    range = 10,
    on_use = minetest.item_eat(3),                                    
	groups = {food_meat = 1, flammable = 2},
    on_place = function(itemstack, placer, pointed_thing)
        if placer and not placer:is_player() then return itemstack end
        if not pointed_thing then return itemstack end
        if not pointed_thing.type == "node" then return itemstack end
        
        local pos = pointed_thing.above
        local number = water_life.count_objects(pos)
        if number.all > water_life.maxmobs or number.fish > 10 then return itemstack end
                                                    
        local name = placer:get_player_name()
        if minetest.is_protected(pos,name) then return itemstack end

        local obj = minetest.add_entity(pos, "water_life:fish_tamed")
        obj = obj:get_luaentity()
        itemstack:take_item()
        obj.owner = name
        return itemstack
    end,
})

minetest.register_craftitem("water_life:piranha", {
	description = ("Piranha"),
	inventory_image = "water_life_piranha_item.png",
    wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    stack_max = 10,
    liquids_pointable = false,
    range = 10,
    on_use = minetest.item_eat(5),                                    
	groups = {food_meat = 1, flammable = 2},
    on_place = function(itemstack, placer, pointed_thing)
        if placer and not placer:is_player() then return itemstack end
        if not pointed_thing then return itemstack end
        if not pointed_thing.type == "node" then return itemstack end
        
        local pos = pointed_thing.above
        local number = water_life.count_objects(pos)
        if number.all > water_life.maxmobs or number.fish > 10 then return itemstack end
                                                    
        local name = placer:get_player_name()
        if minetest.is_protected(pos,name) then return itemstack end

        local obj = minetest.add_entity(pos, "water_life:piranha")
        obj = obj:get_luaentity()
        itemstack:take_item()
        --obj.owner = name
        return itemstack
    end,
})
