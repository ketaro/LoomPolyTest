package
{
    import loom2d.math.Point;
    
    // Base entity class for Poly objects
    // Simple physics engine for motion
    
    public class PolyEntity
    {
        public static const STATE_BOUNCY = 0;
        public static const STATE_SCARED = 1;
        
        protected var state:int = 0;
        
        // Position
        protected var p:Point = new Point();

        // Target Position
        protected var target:Point;

        // Class property to avoid instantiation on every tick
        private var speed:int = 5;
        private var delta:Point;
        private var rate:Number;
        
        // Velocity
        protected var v:Point = new Point();
        
        // Old acceleration
        private var oa:Point = new Point();
        
        // Acceleration
        protected var a:Point = new Point();
        
        // Offset to randomize animations a little
        protected var displayOffset:int = int(Math.random() * 60);
        
        public function Entity() {}
        
        public function tick(t:Number, dt:Number)
        {
            switch (state)
            {
                case STATE_BOUNCY:
                    p.y = target.y + (5 * Math.sin(Math.ceil((t + displayOffset) / 10)));
                    break;
                case STATE_SCARED:

                    delta = target.subtract(p);
                    
                    if (delta.length > speed)
                    {
                        rate = Math.abs(delta.x / delta.y);
                        if (rate > 1)
                            rate = 1;
                        rate = rate * speed;
                        
                        if (delta.x > 0)
                            p.x = p.x + rate;
                        else
                            p.x = p.x - rate;

                        rate = Math.abs(delta.y / delta.x);
                        if (rate > 1)
                            rate = 1;
                        rate = rate * speed;
                        if (delta.y > 0)
                            p.y = p.y + rate;
                        else
                            p.y = p.y - rate;
                        
                        
//                         trace('[PolyEntity] p.x:' + p.x + ' t.x:' + target.x + '  delta:' + delta.x + ' d.len:' + delta.length);
                        
                    }
                    else
                    {
                        // no longer scared
                        state = STATE_BOUNCY;
                    }
                    
                    break;
            }
        }
        
        public function render() {}
        
    }
}