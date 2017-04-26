local UE = UnityEngine
local MovingObject = require"MovingObject"
local GameManager = require"GameManager"
---
-- @module Player

---
-- @type Player
-- @extends MovingObject#MovingObject
local Player = {} Player.__index = Player
setmetatable(Player, MovingObject)
Player.wall_damage = 1
Player.points_per_food = 10
Player.points_per_soda = 20
Player.restart_level_delay = 1

---
-- @function [parent=#Player] Awake
-- @param self
function Player:Awake()
    MovingObject.Awake(self)
    self.animator = self.gameObject:GetComponent(typeof(UE.Animator))
    UpdateBeat:Add(self.Update,self)
end

---
-- @function [parent=#Player] Start
-- @param self
function Player:Start()
    self.food = GameManager.instance.player_food_points
end

---
-- @function [parent=#Player] OnDisable
-- @param self
function Player:OnDisable()
    GameManager.instance.player_food_points = self.food
end

---
-- @function [parent=#Player] Update
-- @param self
function Player:Update()
    if not GameManager.instance.players_turn then return end
    local horizontal = UE.Input.GetAxisRaw("Horizontal")
    local vertical = UE.Input.GetAxisRaw("Vertical")
    if horizontal ~= 0 then vertical = 0 end
    if horizontal ~= 0 or vertical ~= 0 then
        self:AttemptMove(horizontal, vertical)
    end 
end

---
-- @function [parent=#Player] AttemptMove
-- @param self
function Player:AttemptMove(dx,dy)
    self.food = self.food - 1
    MovingObject.AttemptMove(self, dx, dy)
    self:CheckIfGameOver()
    GameManager.instance.players_turn = false
end

---
-- @function [parent=#Player] OnTriggerEnter2D
-- @param self
-- @param UnityEngine_Collider2D#Collider2D other
function Player:OnTriggerEnter2D(other)
    if other.tag == "Exit" then
        coroutine.start(function()
            coroutine.wait(self.restart_level_delay)
            self:Restart()
            self.enabled = false
        end)
    elseif other.tag == "Food" then
        self.food = self.food + self.points_per_food
        other.gameObject:SetActive(false)
    elseif other.tag == "Soda" then
        self.food = self.food + self.points_per_soda
        other.gameObject:SetActive(false)
    end
end

---
-- @function [parent=#Player] onCantMove
-- @param self
function Player:onCantMove(hit)
    local hit_wall = GetLuaComponent(hit.transform.gameObject, "Wall")
    hit_wall:DamageWall(self.wall_damage)
    self.animator:SetTrigger("playerChop")
end

---
-- @function [parent=#Player] Restart
-- @param self
function Player:Restart()
    print("Player:Restart")
end

---
-- @function [parent=#Player] LoseFood
-- @param self
function Player:LoseFood(loss)
    self.animator:SetTrigger("playerHit")
    self.food = self.food - loss
    self:CheckIfGameOver()
end

---
-- @function [parent=#Player] DamagePlayer
-- @param self
function Player:DamagePlayer(loss)
end

---
-- @function [parent=#Player] CheckIfGameOver
-- @param self
function Player:CheckIfGameOver()
end

return Player