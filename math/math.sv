package math;
    import trig::*;

    typedef class vec4;

    class mat4;
        real cmpnts[16];

        function new(input real data[16]);
            this.cmpnts = data;
        endfunction

        function vec4 mul_vec4(vec4 b);
            vec4 out;

            out = new(
                this.cmpnts[0]*b.x + this.cmpnts[1]*b.y + this.cmpnts[2]*b.z + this.cmpnts[3]*b.w,
                this.cmpnts[4]*b.x + this.cmpnts[5]*b.y + this.cmpnts[6]*b.z + this.cmpnts[7]*b.w,
                this.cmpnts[8]*b.x + this.cmpnts[9]*b.y + this.cmpnts[10]*b.z + this.cmpnts[11]*b.w,
                this.cmpnts[12]*b.x + this.cmpnts[13]*b.y + this.cmpnts[14]*b.z + this.cmpnts[15]*b.w
            );

            return out;
        endfunction
    endclass;


    class vec4;
        real x, y, z, w;

        function new(input real x, y, z, w = 1.0);
            this.x = x;
            this.y = y;
            this.z = z;
            this.w = w;
        endfunction

        function void translate(vec4 mov);
            mat4 tmat;
            vec4 out;

            tmat = new({
                1.0, 0.0, 0.0, mov.x,
                0.0, 1.0, 0.0, mov.y,
                0.0, 0.0, 1.0, mov.z,
                0.0, 0.0, 0.0, 1.0
            });
            out = tmat.mul_vec4(this);
            this.x = out.x;
            this.y = out.y;
            this.z = out.z;
            this.w = out.w;
        endfunction

        function void rotate(vec4 rot);
            mat4 rotx, roty, rotz;
            vec4 out;

            rotx = new({
                1.0, 0.0, 0.0, 0.0,
                0.0, cos(rot.x), -sin(rot.x), 0.0,
                0.0, sin(rot.x), cos(rot.x), 0.0,
                0.0, 0.0, 0.0, 1.0
            });

            roty = new({
                cos(rot.y), 0.0, sin(rot.y), 0.0,
                0.0, 1.0, 0.0, 0.0,
                -sin(rot.y), 0.0, cos(rot.y), 0.0,
                0.0, 0.0, 0.0, 1.0
            });

            rotz = new({
                cos(rot.z), -sin(rot.z), 0.0, 0.0,
                sin(rot.z), cos(rot.z), 0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                0.0, 0.0, 0.0, 1.0
            });

            out = rotz.mul_vec4(roty.mul_vec4(rotx.mul_vec4(this)));
            this.x = out.x;
            this.y = out.y;
            this.z = out.z;
            this.w = out.w;
        endfunction

        function void perspective(real fovy, aspect, znear, zfar);
            vec4 out;
            mat4 persp;
            real tanhalffovy;

            tanhalffovy = tan(fovy / 2.0);
            
            persp = new({
                1.0/(aspect * tanhalffovy), 0.0, 0.0, 0.0,
                0.0, 1.0/tanhalffovy, 0.0, 0.0,
                0.0, 0.0, -zfar/(zfar - znear), -1.0,
                0.0, 0.0, -(zfar*znear)/(zfar-znear), 0.0
            });

            out = this.mul_mat4(persp);
            this.x = out.x / out.w;
            this.y = out.y / out.w;
            this.z = out.z / out.w;
            this.w = 1;
        endfunction

        function vec4 mul_mat4(mat4 b);
            vec4 out;

            out = new(
                this.x*b.cmpnts[0] + this.y*b.cmpnts[4] + this.z*b.cmpnts[8] + this.w*b.cmpnts[12],
                this.x*b.cmpnts[1] + this.y*b.cmpnts[5] + this.z*b.cmpnts[9] + this.w*b.cmpnts[13],
                this.x*b.cmpnts[2] + this.y*b.cmpnts[6] + this.z*b.cmpnts[10] + this.w*b.cmpnts[14],
                this.x*b.cmpnts[3] + this.y*b.cmpnts[7] + this.z*b.cmpnts[11] + this.w*b.cmpnts[15]
            );

            return out;
        endfunction

        function string tostr();
            string out;
            $sformat(out, "%.3f %.3f %.3f %.3f", this.x, this.y, this.z, this.w);

            return out;
        endfunction
    endclass;
    

    class vec3;
        real x, y, z;

        function new(real x, y, z);
            this.x = x;
            this.y = y;
            this.z = z;
        endfunction

        function vec3 mul_scalar(real s);
            vec3 out;
            out = new(this.x * s, this.y * s, this.z * s);
            return out;
        endfunction
    endclass


    class quaternion;
        real w, x, y, z;

        function new(real w, x, y, z);
            this.w = w;
            this.x = x;
            this.y = y;
            this.z = z;
        endfunction

        function void mul_quat(quaternion q);
            this.w = this.w * q.w - this.x * q.x - this.y * q.y - this.z * q.z;
            this.x = this.w * q.x + this.x * q.w + this.y * q.z - this.z * q.y;
            this.y = this.w * q.y + this.y * q.w + this.z * q.x - this.x * q.z;
            this.z = this.w * q.z + this.z * q.w + this.x * q.y - this.y * q.x;
        endfunction

        function mat4 tomat4();
            mat4 out;

            real qxx, qyy, qzz, qxz, qxy, qyz, qwx, qwy, qwz;
            qxx = this.x * this.x;
            qyy = this.y * this.y;
            qzz = this.z * this.z;
            qxz = this.x * this.z;
            qxy = this.x * this.y;
            qyz = this.y * this.z;
            qwx = this.w * this.x;
            qwy = this.w * this.y;
            qwz = this.w * this.z;

            out = new({
                1.0 - 2.0 * (qyy + qzz),
                2.0 * (qxy + qwz),
                2.0 * (qxz - qwy),
                0.0,
                2.0 * (qxy - qwz),
                1.0 - 2.0 * (qxx + qzz),
                2.0 * (qyz + qwx),
                0.0,
                2.0 * (qxz + qwy),
                2.0 * (qyz - qwx),
                1.0 - 2.0 * (qxx + qyy),
                0.0,
                0.0, 0.0, 0.0, 1.0
            });

            return out;
        endfunction

        function string tostr();
            string out;
            $sformat(out, "%.3f %.3f %.3f %.3f", this.w, this.x, this.y, this.z);

            return out;
        endfunction
    endclass

    function quaternion angleaxis(real angle, vec3 axis);
        real s;
        vec3 v;
        quaternion out;
        s = sin(angle * 0.5);
        v = axis.mul_scalar(s);

        out = new(cos(angle * 0.5), v.x, v.y, v.z);
        return out;
    endfunction

endpackage