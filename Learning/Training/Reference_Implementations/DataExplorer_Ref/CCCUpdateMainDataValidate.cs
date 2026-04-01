using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi
{
    public class CCCUpdateMainDataValidate : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        // When creating line breaks in your messages, please refrain from using the Format method. 
        // This is because the newline symbol (\n) returned by the Format method often includes an extra slash, resulting in \\n instead of the desired \n.
        // To effectively create line breaks, it's recommended to use the $ (string interpolation) method.
        // This approach not only simplifies the syntax but also avoids the issue with the extra slash.
        // Example using Format: string.Format(@"Some text {0} extra text.", randomVariable)
        // Example using '$': $"Some text {randomVariable} extra text."
        // Example using '$' to include a line break: $"Some text {randomVariable} extra text.\nExtra text in new line"
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/updatemaindata/validate")
                .Handle<PostedID, object[]>("POST", async (posted, qr, ct) =>


                {

                    // List to store the validation results
                    List<object> objects = new List<object>();

                    // Iterate through each column in the posted data
                    foreach (var column in posted.columns)
                    {
                        // Validate "Reason" column
                        if ((column.value.ToString()) == "No Remarks" && column.column == "Remarks")
                        {
                            objects.Add(new { column = column.column, errorMsg = $"This is not an accepted value. Add more details" });
                        }

                        // Validate "Last Name" column
                        else if ((column.value.ToString()) == "2" && column.column == "Automation Level")
                        {
                            objects.Add(new { column = column.column, errorMsg = "Level 2 is locked" });
                        }

                        // Add column to objects if no specific validation is required
                        else
                        {
                            objects.Add(new { column = column.column });
                        }
                    }

                    // Convert the list of objects to an array for the response
                    object[] array = objects.ToArray();

                    // Return the array as the response
                    return array;
                }));



        }

        // Class to represent the posted data
        public class PostedID
        {
            public columnsarray[] element { get; set; }
            public columnsarray[] columns { get; set; }
        }

        // Class to represent each column in the posted data
        public class columnsarray
        {
            public string column { get; set; }
            public object value { get; set; }
        }
    }
}