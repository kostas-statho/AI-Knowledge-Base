#region Copyright 2023 One Identity LLC.
/*
 * ONE IDENTITY LLC. PROPRIETARY INFORMATION
 *
 * This software is confidential.  One Identity, LLC. or one of its affiliates or
 * subsidiaries, has supplied this software to you under terms of a
 * license agreement, nondisclosure agreement or both.
 *
 * You may not copy, disclose, or use this software except in accordance with
 * those terms.
 *
 *
 * Copyright 2023 One Identity LLC.
 * ALL RIGHTS RESERVED.
 *
 * ONE IDENTITY LLC. MAKES NO REPRESENTATIONS OR
 * WARRANTIES ABOUT THE SUITABILITY OF THE SOFTWARE,
 * EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE IMPLIED WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, OR
 * NON-INFRINGEMENT.  ONE IDENTITY LLC. SHALL NOT BE
 * LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE
 * AS A RESULT OF USING, MODIFYING OR DISTRIBUTING
 * THIS SOFTWARE OR ITS DERIVATIVES.
 *
 */
#endregion

using QBM.CompositionApi.DataSources.Files;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Handling;

namespace QBM.CompositionApi.Sdk05_Misc
{
    public class FileSystem
        // uncomment the next line to activate this API provider
        // : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // This call provides access to the file system.
            // File access is possible through the /file route:
            // - download a file (GET fileaccess/file/path/file.txt)
            // - upload a file (POST fileaccess/file/path/file.txt)
            // - delete a file (DELETE fileaccess/file/path/file.txt)

            // Directory access is possible through the /directory route:
            // - list contents of a directory (GET fileaccess/directory/path)
            // - delete a directory (DELETE fileaccess/directory/path)

            builder.AddMethod(new FileStorageMethod("fileaccess", new FileSystemStorage(request =>
            {
                return "<path to root folder>";
            }))
            {
                // set to true if the method should only allow read access
                IsReadOnly = false
            });
        }
    }
}
