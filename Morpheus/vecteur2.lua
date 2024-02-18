


newVector = function(x,y)
    local v = {}
        v.x = x or 0
        v.y = y or 0

        local vectorMT = {}

        function vectorMT.__add(v1,v2)
            local sum = newVector(0,0)
            sum.x = v1.x + v2.x
            sum.y = v1.y + v2.y
            return sum
        end
        
        function vectorMT.__sub(v1,v2)
            local sub = newVector(0,0)
            sub.x = v1.x - v2.x
            sub.y = v1.y - v2.y
            return sub
        end
        
        function vectorMT.__mul(k,v)
            local result = newVector(0,0)
            if type(k)=="number" then
                result.x = k*v.x
                result.y = k*v.y
            else
                result.x = v*k.x
                result.y = v*k.y
            end
            return result
        end
        
        function vectorMT.__unm(v)
            local oppose = newVector(-v.x , -v.y)
            return oppose
        end

        setmetatable(v, vectorMT)


        v.norm = function()
            return math.sqrt(v.x^2 + v.y^2)
        end

        v.normalize = function()
            local norm = v.norm()
            v.x = v.x/norm
            v.y = v.y/norm
            return v
        end
     return v

end
