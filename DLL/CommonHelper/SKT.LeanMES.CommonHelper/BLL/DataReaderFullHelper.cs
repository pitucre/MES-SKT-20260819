using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace SKT.LeanMES.CommonHelper.BLL
{
	public class DataReaderFullHelper
	{
		private System.Type nullableType = typeof(System.Nullable<>);

		public System.Collections.Generic.List<T> FullListFromList<T>(IDataReader reader, bool autoDisposeReader = true, bool IgnoreCase = false) where T : new()
		{
			System.Collections.Generic.List<T> list = new System.Collections.Generic.List<T>();
			try
			{
				System.Collections.Generic.Dictionary<int, DataColumn> dictionary = new System.Collections.Generic.Dictionary<int, DataColumn>();
				System.Collections.Generic.Dictionary<int, Action<T, IDataReader>> dictionary2 = new System.Collections.Generic.Dictionary<int, Action<T, IDataReader>>();
				System.Type typeFromHandle = typeof(T);
				System.Collections.Generic.Dictionary<string, System.Reflection.PropertyInfo> dictionary3 = typeFromHandle.GetProperties().ToDictionary((System.Reflection.PropertyInfo p) => IgnoreCase ? p.Name.ToLower() : p.Name);
				for (int i = 0; i < reader.FieldCount; i++)
				{
					string name = reader.GetName(i);
					DataColumn dataColumn = new DataColumn
					{
						ColumnName = IgnoreCase ? name.ToLower() : name,
						DataType = reader.GetFieldType(i),
						Namespace = reader.GetDataTypeName(i)
					};
					dictionary.Add(i, dataColumn);
					if (dictionary3.ContainsKey(dataColumn.ColumnName))
					{
						System.Reflection.PropertyInfo propertyInfo = dictionary3[dataColumn.ColumnName];
						bool flag = this.IsNullableType(propertyInfo.PropertyType);
						if (flag)
						{
							dictionary2.Add(i, this.SetValueToEntity<T>(i, propertyInfo, dataColumn.DataType, flag));
						}
						else
						{
							dictionary2.Add(i, this.SetValueToEntity<T>(i, dataColumn.ColumnName, dataColumn.DataType));
						}
					}
				}
				while (reader.Read())
				{
					T t = (default(T) == null) ? System.Activator.CreateInstance<T>() : default(T);
					list.Add(t);
					foreach (System.Collections.Generic.KeyValuePair<int, Action<T, IDataReader>> current in dictionary2)
					{
						if (!reader.IsDBNull(current.Key))
						{
							current.Value(t, reader);
						}
					}
				}
			}
			finally
			{
				if (reader != null && autoDisposeReader)
				{
					reader.Close();
					reader.Dispose();
				}
			}
			return list;
		}

		public bool IsNullableType(System.Type theType)
		{
			return theType.IsGenericType && theType.GetGenericTypeDefinition().Equals(this.nullableType);
		}

		public static Func<T, T?> ValueAction<T>() where T : struct
		{
			return (T val) => new T?(val);
		}

		public Action<T, IDataRecord> SetValueToEntity<T>(int index, string ProPertyName, System.Type FieldType)
		{
			System.Type typeFromHandle = typeof(IDataRecord);
			System.Collections.Generic.IEnumerable<System.Reflection.MethodInfo> source = typeFromHandle.GetMethods().Where(delegate(System.Reflection.MethodInfo p)
			{
				bool arg_5A_0;
				if (p.ReturnType == FieldType && p.Name.StartsWith("Get"))
				{
					arg_5A_0 = ((from n in p.GetParameters()
					where n.ParameterType == typeof(int)
					select n).Count<System.Reflection.ParameterInfo>() == 1);
				}
				else
				{
					arg_5A_0 = false;
				}
				return arg_5A_0;
			});
			if (FieldType == typeof(string))
			{
				source = new System.Reflection.MethodInfo[]
				{
					typeFromHandle.GetMethod("GetString")
				};
			}
			if (source.Count<System.Reflection.MethodInfo>() > 0)
			{
				System.Reflection.MethodInfo method = source.FirstOrDefault<System.Reflection.MethodInfo>();
				ParameterExpression parameterExpression = Expression.Parameter(typeof(T), "e");
				ParameterExpression parameterExpression2 = Expression.Parameter(typeFromHandle, "r");
				ConstantExpression constantExpression = Expression.Constant(index);
				MemberExpression left = Expression.PropertyOrField(parameterExpression, ProPertyName);
				MethodCallExpression right = Expression.Call(parameterExpression2, method, new Expression[]
				{
					constantExpression
				});
				BinaryExpression body = Expression.Assign(left, right);
				LambdaExpression lambdaExpression = Expression.Lambda(body, new ParameterExpression[]
				{
					parameterExpression,
					parameterExpression2
				});
				Expression<Action<T, IDataRecord>> expression = Expression.Lambda<Action<T, IDataRecord>>(body, new ParameterExpression[]
				{
					parameterExpression,
					parameterExpression2
				});
				return expression.Compile();
			}
			throw new System.EntryPointNotFoundException("没有从DataReader找到合适的取值方法");
		}

		public Action<T, IDataRecord> SetValueToEntity<T>(int index, System.Reflection.PropertyInfo ProPerty, System.Type FieldType, bool isNnullable)
		{
			Action<T, IDataRecord> result;
			if (!isNnullable)
			{
				result = this.SetValueToEntity<T>(index, ProPerty.Name, FieldType);
			}
			else
			{
				System.Type typeFromHandle = typeof(IDataRecord);
				System.Type[] genericArguments = ProPerty.PropertyType.GetGenericArguments();
				System.Type valType = null;
				if (genericArguments.Length > 0)
				{
					valType = genericArguments[0];
				}
				System.Collections.Generic.IEnumerable<System.Reflection.MethodInfo> source = typeFromHandle.GetMethods().Where(delegate(System.Reflection.MethodInfo p)
				{
					bool arg_5A_0;
					if (p.ReturnType == valType && p.Name.StartsWith("Get"))
					{
						arg_5A_0 = ((from n in p.GetParameters()
						where n.ParameterType == typeof(int)
						select n).Count<System.Reflection.ParameterInfo>() == 1);
					}
					else
					{
						arg_5A_0 = false;
					}
					return arg_5A_0;
				});
				if (FieldType == typeof(string))
				{
					source = new System.Reflection.MethodInfo[]
					{
						typeFromHandle.GetMethod("GetString")
					};
				}
				if (source.Count<System.Reflection.MethodInfo>() <= 0)
				{
					throw new System.EntryPointNotFoundException("没有从DataReader找到合适的取值方法");
				}
				System.Reflection.MethodInfo method = source.FirstOrDefault<System.Reflection.MethodInfo>();
				ParameterExpression parameterExpression = Expression.Parameter(typeof(T), "e");
				ParameterExpression parameterExpression2 = Expression.Parameter(typeFromHandle, "r");
				ConstantExpression constantExpression = Expression.Constant(index);
				MemberExpression left = Expression.PropertyOrField(parameterExpression, ProPerty.Name);
				MethodCallExpression arg = Expression.Call(parameterExpression2, method, new Expression[]
				{
					constantExpression
				});
				System.Reflection.MethodInfo method2 = base.GetType().GetMethod("ValueAction");
				System.Reflection.MethodInfo methodInfo = method2.MakeGenericMethod(new System.Type[]
				{
					valType
				});
				System.Delegate @delegate = (System.Delegate)methodInfo.Invoke(null, null);
				MethodCallExpression right = Expression.Call(@delegate.Method, arg);
				BinaryExpression body = Expression.Assign(left, right);
				LambdaExpression lambdaExpression = Expression.Lambda(body, new ParameterExpression[]
				{
					parameterExpression,
					parameterExpression2
				});
				Expression<Action<T, IDataRecord>> expression = Expression.Lambda<Action<T, IDataRecord>>(body, new ParameterExpression[]
				{
					parameterExpression,
					parameterExpression2
				});
				result = expression.Compile();
			}
			return result;
		}

		public Func<T, IDataReader, T1> SetValueToEntity<T, T1>(int index, string ProPertyName)
		{
			System.Type typeFromHandle = typeof(IDataRecord);
			System.Collections.Generic.IEnumerable<System.Reflection.MethodInfo> source = from p in typeFromHandle.GetMethods()
			where p.ReturnType == typeof(T1)
			select p;
			if (source.Count<System.Reflection.MethodInfo>() > 0)
			{
				System.Reflection.MethodInfo method = source.FirstOrDefault<System.Reflection.MethodInfo>();
				ParameterExpression parameterExpression = Expression.Parameter(typeof(T), "e");
				ParameterExpression parameterExpression2 = Expression.Parameter(typeFromHandle, "r");
				ConstantExpression constantExpression = Expression.Constant(index);
				MemberExpression left = Expression.PropertyOrField(parameterExpression, ProPertyName);
				MethodCallExpression right = Expression.Call(parameterExpression2, method, new Expression[]
				{
					constantExpression
				});
				BinaryExpression body = Expression.Assign(left, right);
				LambdaExpression lambdaExpression = Expression.Lambda(body, new ParameterExpression[]
				{
					parameterExpression,
					parameterExpression2
				});
				Expression<Func<T, IDataRecord, T1>> expression = Expression.Lambda<Func<T, IDataRecord, T1>>(body, new ParameterExpression[]
				{
					parameterExpression,
					parameterExpression2
				});
				return expression.Compile();
			}
			throw new System.EntryPointNotFoundException("没有从DataReader找到合适的取值方法");
		}

		public Func<T, IDataReader, T1> SetValueToEntity<T, T1>(int index, string ProPertyName, string DataReaderGetValueMethodName)
		{
			ParameterExpression parameterExpression = Expression.Parameter(typeof(T), "e");
			ParameterExpression parameterExpression2 = Expression.Parameter(typeof(IDataRecord), "r");
			ConstantExpression constantExpression = Expression.Constant(index);
			MemberExpression left = Expression.PropertyOrField(parameterExpression, ProPertyName);
			MethodCallExpression right = Expression.Call(parameterExpression2, typeof(IDataRecord).GetMethod(DataReaderGetValueMethodName, new System.Type[]
			{
				typeof(int)
			}), new Expression[]
			{
				constantExpression
			});
			BinaryExpression body = Expression.Assign(left, right);
			LambdaExpression lambdaExpression = Expression.Lambda(body, new ParameterExpression[]
			{
				parameterExpression,
				parameterExpression2
			});
			Expression<Func<T, IDataRecord, T1>> expression = Expression.Lambda<Func<T, IDataRecord, T1>>(body, new ParameterExpression[]
			{
				parameterExpression,
				parameterExpression2
			});
			return expression.Compile();
		}

		public Func<T, IDataRecord, int, T1> SetPropertyValue<T, T1>(int index, T Entity, string ProPertyName, string DataReaderGetValueMethodName)
		{
			ParameterExpression parameterExpression = Expression.Parameter(typeof(T), "e");
			ParameterExpression parameterExpression2 = Expression.Parameter(typeof(IDataRecord), "r");
			ParameterExpression parameterExpression3 = Expression.Parameter(typeof(int), "index");
			MemberExpression left = Expression.PropertyOrField(parameterExpression, ProPertyName);
			MethodCallExpression right = Expression.Call(parameterExpression2, typeof(IDataRecord).GetMethod(DataReaderGetValueMethodName, new System.Type[]
			{
				typeof(int)
			}), new Expression[]
			{
				parameterExpression3
			});
			BinaryExpression body = Expression.Assign(left, right);
			LambdaExpression lambdaExpression = Expression.Lambda(body, new ParameterExpression[]
			{
				parameterExpression,
				parameterExpression2,
				parameterExpression3
			});
			Expression<Func<T, IDataRecord, int, T1>> expression = Expression.Lambda<Func<T, IDataRecord, int, T1>>(body, new ParameterExpression[]
			{
				parameterExpression,
				parameterExpression2,
				parameterExpression3
			});
			return expression.Compile();
		}

		private System.Collections.Generic.IEnumerable<T> SearchTcontains<T>(IQueryable<T> entity, string propertyname, string value)
		{
			ParameterExpression parameterExpression = Expression.Parameter(typeof(T), "c");
			MemberExpression instance = Expression.Property(parameterExpression, "CustomerID");
			ConstantExpression constantExpression = Expression.Constant(value);
			Expression body = Expression.Call(instance, typeof(string).GetMethod("Contains", new System.Type[]
			{
				typeof(string)
			}), new Expression[]
			{
				constantExpression
			});
			Expression<Func<T, bool>> expression = Expression.Lambda<Func<T, bool>>(body, new ParameterExpression[]
			{
				parameterExpression
			});
			return null;
		}
	}
}
