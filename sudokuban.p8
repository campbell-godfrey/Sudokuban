pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
--main setup
--level
level_var=0

--crates setup
crt_col=9 
plr_spr=1 
--function def_crt_spr(x,y)
--
def_crt_spr=48 
def_grnd_spr=16 
def_trgt_spr=52 
--title screen
title_screen = {}
title_screen.title = {}
--game title
title_screen.title.text = "sudokuban"
title_screen.title.x = 25
title_screen.title.y = 25
title_screen.title.col = 3
--author section
title_screen.author = {}
title_screen.author.text = "by campbell godfrey"
title_screen.author.x = 45
title_screen.author.y = 35
title_screen.author.col = 7
--end screen
end_screen = {}
end_screen.txt = "fin."
end_screen.x = 65
end_screen.y = 60
end_screen.col = 7

--◆levels config
lvls = {}

lvls[1] = {x=0,y=0,soffx=32,soffy=32,widx=9,widy=9,msg="sudoku warm-up",msg_x=45,msg_y=60,level_crates=4}
lvls[2] = {x=9,y=0,soffx=32,soffy=32,widx=9,widy=9,msg="sorry there are no 3x3 boxes",msg_x=25,msg_y=60}
lvls[3] = {x=18,y=0,soffx=32,soffy=32,widx=9,widy=9,msg="",msg_x=45,msg_y=60}
lvls[4] = {x=24,y=0,soffx=32,soffy=32,widx=8,widy=8,msg="",msg_x=40,msg_y=60}
lvls[5] = {x=0,y=8,soffx=0,soffy=32,widx=16,widy=8,msg="",msg_x=40,msg_y=60}
lvls[6] = {x=16,y=8,soffx=0,soffy=32,widx=16,widy=8,msg="",msg_x=40,msg_y=60}
lvls[7] = {x=0,y=16,soffx=40,soffy=32,widx=6,widy=6,msg="",msg_x=40,msg_y=60}
lvls[8] = {x=6,y=16,soffx=40,soffy=32,widx=6,widy=7,msg="",msg_x=40,msg_y=60}
lvls[9] = {x=12,y=16,soffx=40,soffy=32,widx=8,widy=8,msg="",msg_x=40,msg_y=60}
lvls[10] = {x=20,y=16,soffx=32,soffy=32,widx=9,widy=9,msg="",msg_x=40,msg_y=60}
-->8

--player config
plr={}
plr.curr_tile = 0

--game state set
gm={}
gm.state = 0
gm.curr_lvl = 0
gm.level={}
--player spawn
gm.level.strt = {}
gm.level.strt.x = 0
gm.level.strt.y = 0
--targets list
gm.level.targets = {}
--crates list
gm.level.crates = {}
gm.level.crates_init = {}
--offset value to center the map
gm.level.soffx = 0
gm.level.soffy = 0
--width of the level on map tab
gm.level.widx = 0
gm.level.widy = 0
--lvl x/y on the map tab
gm.level.x = 0
gm.level.y = 0

-->8
--helper functions
function level_loader(lvl) 
	local x,y,curr_tile,org_crt_spr,map_x,map_y
	local crt_cnt = 1
	local trgt_cnt = 1
	--reset the crate/target arrays
	gm.level.crates={}
	gm.level.crates_init={}
	gm.level.targets={}	
	gm.level.x = lvls[lvl].x
	gm.level.y = lvls[lvl].y
	gm.level.soffx = lvls[lvl].soffx
	gm.level.soffy = lvls[lvl].soffy
	gm.level.widx = lvls[lvl].widx
	gm.level.widy = lvls[lvl].widy
	--map scan
	for x=gm.level.x*8+gm.level.soffx,((gm.level.x*8)+gm.level.widx*8)+gm.level.soffx,8 do
		for y=gm.level.y*8+gm.level.soffy,((gm.level.y*8)+gm.level.widy*8)+gm.level.soffy,8 do 
			local sx,sy
			sx = x-(gm.level.x*8)
			sy = y-(gm.level.y*8)
			curr_tile=get_map_pos(sx,sy)
			curr_tile_m=mget(sx,sy)
			curr_tile_flag=fget(curr_tile)
			if__crate=fget(curr_tile,1)
			if__flag=fget(curr_tile,7)
			map_x=to_map_val(x,"x")
			map_y=to_map_val(y,"y")
			--spawn
			if(curr_tile_flag==252)then
				gm.level.strt.x = sx
				gm.level.strt.y = sy
			--targets
			elseif(if__flag==true)then
				add(gm.level.targets,{id=trgt_cnt,x=x,y=y})
				trgt_cnt=trgt_cnt+1
			--crates
			elseif((if__flag==true)or(if__crate==true))then
				if(if__flag==true)then
					org_crt_spr=mget(map_x,map_y)
				elseif(if__crate==true)then
					if curr_tile_flag==10 then
						org_crt_spr=44
					elseif curr_tile_flag==18 then
						org_crt_spr=45
					elseif curr_tile_flag==38 then
						org_crt_spr=46
					elseif curr_tile_flag==66 then
						org_crt_spr=47
					elseif curr_tile_flag==70 then
						org_crt_spr=48
					elseif curr_tile_flag==74 then
						org_crt_spr=49
					elseif curr_tile_flag==82 then
						org_crt_spr=50
					elseif curr_tile_flag==98 then
						org_crt_spr=51
					else
						org_crt_spr=43
						--org_crt_spr=def_crt_spr
					end
				end
				add(gm.level.crates,{id=crt_cnt,x=x,y=y,org_spr=org_crt_spr})
				--copy of table for resets
				add(gm.level.crates_init,{id=crt_cnt,x=x,y=y,org_spr=org_crt_spr})
				--sets the tile to a ground tile instead
				if(if__crate)then
					mset(map_x,map_y,16)
				elseif(if__flag)then
					add(gm.level.targets,{id=trgt_cnt,x=x,y=y})
					trgt_cnt=trgt_cnt+1
					mset(map_x,map_y,def_trgt_spr)										
				end
				--store last known spr to replace when moved
				gm.level.crates[crt_cnt].last_tile=mget(map_x,map_y)
				crt_cnt=crt_cnt+1
			end			
		end
	end
	--set spawm
	plr.x = gm.level.strt.x
	plr.y = gm.level.strt.y
end

--crate functions
function get_crate_id(x,y)
	for i=1,#gm.level.crates do
		if (gm.level.crates[i].x==x) and(gm.level.crates[i].y==y)then
			return	gm.level.crates[i].id
		end
	end
end

function get_crt_lst_spr(id)
	for i=1,#gm.level.crates do
		if(gm.level.crates[i].id==id) then
			return gm.level.crates[i].last_tile
		end
	end
end

function set_crate(id,x,y,last_tile)
	for i=1,#gm.level.crates do
		if(gm.level.crates[i].id==id)then
			gm.level.crates[i].x = x
			gm.level.crates[i].y = y			
			gm.level.crates[i].last_tile = last_tile
		end
	end
end

function draw_crates(o)
	local m_x=to_map_val(o.x,"x")
	local m_y=to_map_val(o.y,"y")
	local cell=get_map_pos(o.x,o.y)
	mset(m_x,m_y,o.org_spr)
	
end

--general purpose
function get_map_pos(x,y)
	return mget(flr((x-gm.level.soffx)/8)+gm.level.x,flr((y-gm.level.soffy)/8)+gm.level.y)
end

function to_map_val(val,axis)
	if(axis=="x")then
		return flr((val-gm.level.soffx)/8)
	elseif(axis=="y")then
		return flr((val-gm.level.soffy)/8)
	end
end

function reset_crates()
	for i=1,#gm.level.crates do
		--reset tile spr
		mset(to_map_val(gm.level.crates[i].x,"x"),to_map_val(gm.level.crates[i].y,"y"),get_crt_lst_spr(i))
		--reset x/y
		set_crate(i,gm.level.crates_init[i].x,gm.level.crates_init[i].y,mget(to_map_val(gm.level.crates_init[i].x,"x"),to_map_val(gm.level.crates_init[i].y,"y")))
	end
end

--check if all crates have same x/y as targets
function check_end_condition()
	local cnt = 0
	local result = false
	for i=1,#gm.level.crates do
		for j=1,#gm.level.targets do
			crates__m=mget(gm.level.crates[i].x,gm.level.crates[i].y)
			targets__m=mget(gm.level.targets[j].x,gm.level.targets[j].y)
			crates_num=fget(crates__m)
			targets_num=fget(targets__m)
			print(crates_num)
			--if (crates_num-128)==(targets_num-128)then
				--crates__m=0
				--targets__m=0
				--crates_num=0
				--targets_num=0
				if((gm.level.crates[i].x==gm.level.targets[j].x)and(gm.level.crates[i].y==gm.level.targets[j].y))then
					cnt=cnt+1
				end
			--end
		end
	end
	if(level_var==1 and cnt==4)then
		result = true
	elseif(level_var==2 and cnt==2)then
		result = true
	end
	return result
end

function nxt_lvl_load()
	--if not last level
	gm.curr_lvl=gm.curr_lvl+1
	if(gm.curr_lvl<=#lvls)then
		level_loader(gm.curr_lvl)
		gm.state=2
	else
		--set to end state
		gm.state = 3
		--reload map to orignal state
		reload(0x2000, 0x2000, 0x1000)
	end
end


-->8
--state functions
--menu state
menu_select = 0
menu_select_max = 0
menu_help = false

--menu state
function menu_state_draw()
	menu_select=0
	print(title_screen.title.text,title_screen.title.x,title_screen.title.y,title_screen.title.col)
	print(title_screen.author.text,title_screen.author.x,title_screen.author.y,title_screen.author.col)
	print("z - start",50,100,7)
end

function menu_state_input()
	if(menu_help==false)then
		if(btnp(2))then
			if(menu_select!=0)then
				menu_select=menu_select-1
			else
				--rollover
				menu_select=menu_select_max
			end
		elseif(btnp(3))then
			if(menu_select!=menu_select_max)then
				menu_select=menu_select+1
			else
				--rollover
				menu_select=0
			end
		elseif(btnp(4))then
			if(menu_select==0)then
				--set to game state
				gm.curr_lvl=0
				nxt_lvl_load()
				gm.state=2
			elseif(menu_select==1)then
				menu_help=true
			end
		end
	elseif(menu_help==true)then
		if(btnp(4))then
			menu_help=false
		end
	end
end

--game state
function game_state_draw()
	map(gm.level.x, gm.level.y, gm.level.soffx, gm.level.soffy, gm.level.widx, gm.level.widy)
	--draw player
 spr(plr_spr, plr.x, plr.y) 
 --draws all movable crates
	foreach(gm.level.crates,draw_crates)
end

function game_state_input()
	player_controls()
end

--transition state
function trns_state_draw()
	print("level:"..gm.curr_lvl,50,50)
	print(lvls[gm.curr_lvl].msg,lvls[gm.curr_lvl].msg_x,lvls[gm.curr_lvl].msg_y)
	print("z - next!",48,120,7)
end

function trns_state_input()
	if(btnp(4))then
		gm.state=1
		level_var=level_var+1
	end
end

--end state
function end_state_draw()
	print(end_screen.txt,end_screen.x,end_screen.y,end_screen.col)
	print("z - cool!",55,120,7) 	
end

function end_state_input()
	if(btnp(4))then
		gm.state=0
	end
end
-->8
--player
function player_controls()
	--movement
	--down
	if btnp(2) then
		if(collision_checker(2) == false) then
			plr.y -= 8
		end	
	end
	--up
	if btnp(3) then
		if(collision_checker(3) == false) then
			plr.y += 8
		end
	end
	if btnp(5) then
		reset_level()
	end
	--left
	if btnp(0) then
		if(collision_checker(0) == false) then
			plr.x -= 8
		end
	end
	--right
	if btnp(1) then
		if(collision_checker(1) == false) then
			plr.x += 8
		end
	end
end

function collision_checker(direct)
	local result = false
	local col_tile,col_psh_chk
	local x,y,psh_x,psh_y,crate_id
		if(direct == 0) then
			x = plr.x-8
			y = plr.y
		elseif(direct == 1) then
 		x = plr.x+8
 		y = plr.y
		elseif(direct == 2) then
			x = plr.x
			y = plr.y-8
		elseif(direct == 3) then
			x = plr.x
			y = plr.y+8
		end
		col_tile=get_map_pos(x,y)
		local if_wall=fget(col_tile,0)
		local if_crate=fget(col_tile,1)
		--wall
		if (if_wall == true) then
			result = true
			return result
		end
		--crate push
		if (if_crate == true) then
			if(direct == 0) then
				psh_x = x-8
				psh_y = y
			elseif(direct == 1) then
				psh_x = x+8
				psh_y = y
			elseif(direct == 2) then
				psh_x = x
				psh_y = y-8
			elseif(direct == 3) then
 			psh_x = x
 			psh_y = y+8
			end
			--check if next tile is free
			col_psh_chk=get_map_pos(psh_x,psh_y)
			local col_psh_type=fget(col_psh_chk,1)
			local col_psh_type2=fget(col_psh_chk,0)
			if(col_psh_type!=true and col_psh_type2!=true)then
				crate_id=get_crate_id(x+(gm.level.x*8),y+(gm.level.y*8))
				--set spr under crate back to what it was
				mset(to_map_val(x+(gm.level.x*8),"x"),to_map_val(y+(gm.level.y*8),"y"),get_crt_lst_spr(crate_id))
				--move create + store tile spr
				set_crate(crate_id,psh_x+(gm.level.x*8),psh_y+(gm.level.y*8),mget(to_map_val(psh_x+(gm.level.x*8),"x"),to_map_val(psh_y+(gm.level.y*8),"y")))
				if(check_end_condition())then
					nxt_lvl_load()
					result = true
				end
				return result
			--no space = no push/move
			else
				result = true
				return result
			end
		end
	return result
end

function reset_level()
	plr.x = gm.level.strt.x
	plr.y = gm.level.strt.y
	reset_crates()
end

-->8
--main loop
function _init()
	gm.state = 0
end

function _draw()
	cls()
	--menu state
	if(gm.state == 0) then
		menu_state_draw()
	--game state
	elseif(gm.state == 1) then
		game_state_draw()
	elseif(gm.state == 2) then
		trns_state_draw()
	elseif(gm.state == 3) then
		end_state_draw()
	end
end

function _update()
	--menu state
	if(gm.state == 0) then
		menu_state_input()
	--game state
	elseif(gm.state == 1) then
		game_state_input()
		plr.curr_tile = get_map_pos(plr.x,plr.y)
	elseif(gm.state == 2) then
		trns_state_input()
	elseif(gm.state == 3) then
		end_state_input()
	end
end
__gfx__
00000000229889220000000000000000000000008888888888888888888888888888888888888888888888888888888888888888888888880000000000000000
00000000900000090000000000000000000000008355553883555538835555388355553883555538835555388355553883555538835555380000000000000000
00000000800000080000000000000000000000008535535885355358853553588535535885355358853553588535535885355358853553580000000000000000
00000000d000000d0000000000000000000000008553355885533558855335588553355885533558855335588553355885533558855335580000000000000000
00000000d000000d0000000000000000000000008553355885533558855335588553355885533558855335588553355885533558855335580000000000000000
00000000800000080000000000000000000000008535535885355358853553588535535885355358853553588535535885355358853553580000000000000000
00000000900000090000000000000000000000008355553883555538835555388355553883555538835555388355553883555538835555380000000000000000
00000000229889220000000000000000000000008888888888888888888888888888888888888888888888888888888888888888888888880000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0ffffff00fcccff00fccccf00fccccf00fcffcf00fccccf00fccccf00fccccf00fccccf00fccccf0000000000000000000000000000000000000000000000000
0ffffff00ffccff00ffffcf00ffffcf00fcffcf00fcffff00fcffff00ffffcf00fcffcf00fcffcf0000000000000000000000000000000000000000000000000
0ffffff00ffccff00ffffcf00fccccf00fccccf00fccccf00fcffff00fffccf00fccccf00fccccf0000000000000000000000000000000000000000000000000
0ffffff00ffccff00fccccf00ffffcf00ffffcf00ffffcf00fccccf00ffccff00fcffcf00ffffcf0000000000000000000000000000000000000000000000000
0ffffff00ffccff00fcffff00ffffcf00ffffcf00ffffcf00fcffcf00ffcfff00fcffcf00ffffcf0000000000000000000000000000000000000000000000000
0ffffff00fccccf00fccccf00fccccf00ffffcf00fccccf00fccccf00ffcfff00fccccf00ffffcf0000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111111111111111111111111111111111111111111111111111111111111558558555585585555855855558558555585585555855855
1dcddcd11deee6d11deeeed11deeeed11de66ed11deeeed11deeeed11deeeed11deeeed11deeeed1506666055044460550444405504444055046640550444405
1c6666c11c6ee6c11c666ec11c666ec11ce66ec11ce666c11ce666c11c666ec11ce66ec11ce66ec1806666088064460880666408806664088046640880466608
1dcddcd11d6ee6d11d666ed11deeeed11deeeed11deeeed11de666d11d66eed11deeeed11deeeed1566666655664466556666465564444655644446556444465
1dcddcd11d6ee6d11deeeed11d666ed11d666ed11d666ed11deeeed11d6ee6d11de66ed11d666ed1566666655664466556444465566664655666646556666465
1c6666c11c6ee6c11ce666c11c666ec11c666ec11c666ec11ce66ec11c6e66c11ce66ec11c666ec1806666088064460880466608806664088066640880666408
1dcddcd11deeeed11deeeed11deeeed11d666ed11deeeed11deeeed11d6e66d11deeeed11d666ed1506666055044440550444405504444055066640550444405
11111111111111111111111111111111111111111111111111111111111111111111111111111111558558555585585555855855558558555585585555855855
5585585555855855558558555585585588888888bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00000000
5044440550444405504444055044440583555538baccccabbcaaaccbbcaaaacbbcaaaacbbcaccacbbcaaaacbbcaaaacbbcaaaacbbcaaaacbbcaaaacb00000000
8046660880666408804664088046640885355358bcaccacbbccaaccbbccccacbbccccacbbcaccacbbcaccccbbcaccccbbccccacbbcaccacbbcaccacb00000000
5646666556664465564444655644446585533558bccaaccbbccaaccbbccccacbbcaaaacbbcaaaacbbcaaaacbbcaccccbbcccaacbbcaaaacbbcaaaacb00000000
5644446556644665564664655666646585533558bccaaccbbccaaccbbcaaaacbbccccacbbccccacbbccccacbbcaaaacbbccaaccbbcaccacbbccccacb00000000
8046640880646608804664088066640885355358bcaccacbbccaaccbbcaccccbbccccacbbccccacbbccccacbbcaccacbbccacccbbcaccacbbccccacb00000000
5044440550646605504444055066640583555538baccccabbcaaaacbbcaaaacbbcaaaacbbccccacbbcaaaacbbcaaaacbbccacccbbcaaaacbbccccacb00000000
5585585555855855558558555585585588888888bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000003303330333033303330000033303030033030303330333000000000000000000000000000000000000
00000000000000000000000000000000000000000000030003030303003003000000030303030300030303000303000000000000000000000000000000000000
00000000000000000000000000000000000000000000030003300333003003300000033303030333033303300330000000000000000000000000000000000000
00000000000000000000000000000000000000000000030003030303003003000000030003030003030303000303000000000000000000000000000000000000
00000000000000000000000000000000000000000000003303030303003003330000030000330330030303330303000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000077707070000070700770777077707770707000007770777070700000000000000000000000000000000
00000000000000000000000000000000000000000000070707070070070707070070007007000707000007070707070700000000000000000000000000000000
00000000000000000000000000000000000000000000077007770000070707070070007007700770000007700777077000000000000000000000000000000000
00000000000000000000000000000000000000000000070700070070077707070070007007000707000007070707070700000000000000000000000000000000
00000000000000000000000000000000000000000000077707770000077707700770007007770707000007070707070700000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000700000770777077707770777000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000007770007000070070707070070000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000077777007770070077707700070000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000007770000070070070707070070000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000700007700070070707070070000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000505055505000555000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000505050005000505000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000555055005000555000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000505050005000500000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000505055505550500000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
0000000000848890a0c0c4c8d0e00000000000000000000000000000000000000101010101010101010102060a122242464a526280fcfcfcfcfcfcfcfcfcfc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
2523242627282921222523202027202020202020202020202020202020202020150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2617121119151314282610101119151010202012121212101010202012121220150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21193d1314121516272019181010101016202012121212101010202012121220150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
281519320a301412232833101016103110232012121212101012202012121220150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2412160c15071719212410101810131010212012121212101010202012121220150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2711132d062c1815262710321012101010262012121212101010202012121220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2916111513171218242016101010101218202012121212101012202012121220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2218171411191613252010101411191010252010101010101010202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2324252228262127292020202028202027292020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101010111111101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101111111010101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101010101010101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101010101010101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101010101010101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101010101010101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101010101010101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101010101010101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101010101010101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2010101010101010101010101010101010101010101010101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000a0500105008050090500805004050080500605007050090500605003050080500c05009050050500b050040500505002050030500505008050010500605001050010500605006050060500605006050
__music__
00 02424344

