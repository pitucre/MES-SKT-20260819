/****************************************************************************
*  Author: Alen Liu
*  Create Datetime: 2014-01-10
*  Desc: Excel js
*  Version: 1.0.0
*  Email: shzalen@163.com
****************************************************************************/
/*设置导出报表边框*/
function setRangeBorders(xlSheet, startRow, endRow, startCol, endCol, borderEntity) {
    if (borderEntity == null) {
        borderEntity = {};
        borderEntity.LineStyle = 1;
        borderEntity.Weight = 2;
        borderEntity.ColorIndex = -4105;
    }
    else {
        borderEntity.LineStyle = (borderEntity.LineStyle == undefined || borderEntity.LineStyle == null) ? 1 : borderEntity.LineStyle;
        borderEntity.Weight = (borderEntity.Weight == undefined || borderEntity.Weight == null) ? 2 : borderEntity.Weight;
        borderEntity.ColorIndex = (borderEntity.ColorIndex == undefined || borderEntity.ColorIndex == null) ? -4105 : borderEntity.ColorIndex;
    }
    with (xlSheet) {
        with (Range(Cells(startRow, startCol), Cells(endRow, endCol))) {
            //Left
            Borders(7).LineStyle = borderEntity.LineStyle;
            Borders(7).Weight = borderEntity.Weight;
            Borders(7).ColorIndex = borderEntity.ColorIndex;
            //Top
            Borders(8).LineStyle = borderEntity.LineStyle;
            Borders(8).Weight = borderEntity.Weight;
            Borders(8).ColorIndex = borderEntity.ColorIndex;
            //Bottom
            Borders(9).LineStyle = borderEntity.LineStyle;
            Borders(9).Weight = borderEntity.Weight;
            Borders(9).ColorIndex = borderEntity.ColorIndex;
            //Rigth
            Borders(10).LineStyle = borderEntity.LineStyle;
            Borders(10).Weight = borderEntity.Weight;
            Borders(10).ColorIndex = borderEntity.ColorIndex;

            if (startCol < endCol) {
                Borders(11).LineStyle = borderEntity.LineStyle;
                Borders(11).Weight = borderEntity.Weight;
                Borders(11).ColorIndex = borderEntity.ColorIndex;
            }

            if (startRow < endRow) {
                Borders(12).LineStyle = borderEntity.LineStyle;
                Borders(12).Weight = borderEntity.Weight;
                Borders(12).ColorIndex = borderEntity.ColorIndex;
            }
        }
    }
}