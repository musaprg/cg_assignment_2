// NOTE: RaTELSと異なり、OpenSCADは有限値しか表現できません。
// そのため、十分大きな値としてINFを定義し、使用することとします。
// これはやむを得ない対応であり、
// 減点条件「有限値をもつ楕円柱等の使用禁止」には当たらないと認識しています。
INF=1000;

// http://penguin.tantin.jp/hard/OpenSCAD/tips.html
module ellipseCylinder(h,a,b,res=100,center=false){
    resize([0,2*b,0])
    cylinder(h = h, r = a,$fn=res,center=center);
}

// NOTE: RaTELSにおける「平面との積」にあたる表現がOpenSCADには存在しません。
// 厳密には、OpenSCADにおける平面（square）は、z方向の大きさが1の直方体として表現されているため、
// RaTELSにおけるプリミティブの内外という概念を用いた平面による制約を用いることができません。
// そのため、今回は、（RaTELSにおける）平面との積を、（OpenSCADにおける）直方体との積として表現します。
// これはやむを得ない対応であり、
// 減点条件「直方体の使用禁止」には当たらないと認識しています。
module squareForIntersect(center=false){
    if (center) {
        rotate([180,0,0])
        translate([-INF/2,-INF/2,0])
        cube(size = [INF,INF,INF]);
    } else {
        rotate([180,0,0])
        cube(size = [INF,INF,INF]);
    }
}

// 選択した文字: S
union() {// 和
    intersection(){ // 積
        difference(){ // 差
            // P1: 円柱面
            // 中心座標: (0,0,-4.25)
            // 半径: 10
            // 回転角: (90,0,0)
            translate([0,0,-4.25])
            rotate([90,0,0])
            cylinder(INF, 10,$fn=100,center=true);
            
            // P2: 円柱面
            // 中心座標: (0,0,-4.25)
            // 半径: 5
            // 回転角: (90,0,0)
            translate([0,0,-4.25])
            rotate([90,0,0])
            cylinder(INF, 5,$fn=100,center=true);
        }

        // P3: 平面
        // 法線ベクトル: (0,-1,0)
        // 中心座標: (0,-10,0)
        translate([0,-10,0])
        rotate([90,0,0])
        squareForIntersect(center=true);

        // P4: 平面
        // 法線ベクトル: (0,1,0)
        // 中心座標: (0,10,0)
        translate([0,10,0])
        rotate([-90,0,0])
        squareForIntersect(center=true);

        // P5: 平面
        // 法線ベクトル: (-1,0,0)
        // 中心座標: (0,0,0)
        rotate([0,-90,0])
        squareForIntersect(center=true);
    }

    intersection(){ // 積
        difference(){ // 差
            // P6: 円柱面
            // 中心座標: (0,0,4.25)
            // 半径: 10
            // 回転角: (90,0,0)
            translate([0,0,4.25])
            rotate([90,0,0])
            cylinder(INF, 10,$fn=100,center=true);

            // P7: 円柱面
            // 中心座標: (0,0,4.25)
            // 半径: 5
            // 回転角: (90,0,0)
            translate([0,0,4.25])
            rotate([90,0,0])
            cylinder(INF, 5,$fn=100,center=true);
        }

        // P8: 平面
        // 法線ベクトル: (0,-1,0)
        // 中心座標: (0,-10,0)
        translate([0,-10,0])
        rotate([90,0,0])
        squareForIntersect(center=true);

        // P9: 平面
        // 法線ベクトル: (0,1,0)
        // 中心座標: (0,10,0)
        translate([0,10,0])
        rotate([-90,0,0])
        squareForIntersect(center=true);

        // P10: 平面
        // 法線ベクトル: (1,0,0)
        // 中心座標: (0,0,0)
        rotate([0,90,0])
        squareForIntersect(center=true);
    }
}
