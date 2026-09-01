using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;

public static class ListExtensions
{
    private static readonly Dictionary<Type, PropertyInfo[]> PropertyCache = new Dictionary<Type, PropertyInfo[]>();

    /// <summary>
    /// List转为DataSet
    /// </summary>
    /// <param name="key">键(必须为TEntity中可以访问的属性)</param>
    /// <param name="arr">List按<paramref name="arr"/>中包含的<paramref name="key"/>筛选</param>
    public static DataSet ToDataSet<T>(this List<T> list, Func<T, bool> filter)
    {
        if (list == null || list.Count == 0)
        {
            throw new ArgumentException("List不能为空或者没有数据。", nameof(list));
        }

        if (filter != null)
        {
            list = list.MatchEntities(filter);
        }

        return Convert(list);
    }

    /// <summary>
    /// List转为DataSet
    /// </summary>
    /// <param name="list">需要处理的List集合</param>
    /// <param name="indices">List按索引筛选</param>
    public static DataSet ToDataSet<T>(this List<T> list, int[] indices = null)
    {
        if (list == null || list.Count == 0)
        {
            throw new ArgumentException("List不能为空或者没有数据。", nameof(list));
        }

        if (indices != null && indices.Length > 0)
        {
            list = list.GetElementsAtIndices(indices);
        }

        return Convert(list);
    }

    private static DataSet Convert<T>(List<T> list)
    {
        DataSet dataSet = new DataSet();
        DataTable dataTable = new DataTable();
        dataSet.Tables.Add(dataTable);

        PropertyInfo[] propertyInfoArray;

        // 尝试从缓存中获取属性信息
        if (PropertyCache.ContainsKey(typeof(T)))
        {
            propertyInfoArray = PropertyCache[typeof(T)];
        }
        else
        {
            // 如果缓存中没有，则获取属性信息并添加到缓存
            propertyInfoArray = typeof(T).GetProperties();
            PropertyCache[typeof(T)] = propertyInfoArray;
        }

        foreach (PropertyInfo propertyInfo in propertyInfoArray)
        {
            Type propertyType = Nullable.GetUnderlyingType(propertyInfo.PropertyType) ?? propertyInfo.PropertyType;
            dataTable.Columns.Add(propertyInfo.Name, propertyType);
        }

        foreach (T item in list)
        {
            DataRow dataRow = dataTable.NewRow();
            foreach (PropertyInfo propertyInfo in propertyInfoArray)
            {
                object value = propertyInfo.GetValue(item);
                dataRow[propertyInfo.Name] = value ?? DBNull.Value;
            }
            dataTable.Rows.Add(dataRow);
        }

        return dataSet;
    }

    private static List<T> MatchEntities<T>(this List<T> entities, Func<T, bool> filter)
    {
        var matchingEntities = entities
            .Where(filter)
            .ToList();

        return matchingEntities;
    }

    private static List<T> GetElementsAtIndices<T>(this List<T> list, int[] indices)
    {
        return indices.Select(i => list[i]).ToList();
    }
}
