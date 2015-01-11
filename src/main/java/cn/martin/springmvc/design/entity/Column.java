package cn.martin.springmvc.design.entity;

/**
 * Created by martin on 2015-01-09.
 * 视图列对象
 */
public class Column {

    //列ID
    private String id;

    //列的显示名称
    private String name;

    //所属组件
    private String pid;

    //排列顺序
    private int sort;

    //列的宽度
    private String width;

    //绑定数据源对应字段
    private String source;

    //数据源字段类型
    private String type;

}
