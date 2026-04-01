# Office Productivity — External Resources

## Excel .NET Libraries
| Library | License | Notes |
|---|---|---|
| [ClosedXML](https://github.com/ClosedXML/ClosedXML) | MIT | OpenXML wrapper; fluent API; no Office required |
| [EPPlus](https://github.com/EPPlusSoftware/EPPlus) | Commercial | Enterprise Excel; requires license for commercial use |
| [Excel-DNA](https://excel-dna.net/) | MIT | Build Excel add-ins with .NET |
| [OpenXML SDK](https://github.com/dotnet/Open-XML-SDK) | MIT | Low-level XML; verbose but full control |

## PowerPoint .NET Libraries
| Library | License | Notes |
|---|---|---|
| [ShapeCrawler](https://github.com/ShapeCrawler/ShapeCrawler) | MIT | OpenXML wrapper for PPTX; no Office required |
| [Open XML SDK](https://github.com/dotnet/Open-XML-SDK) | MIT | Low-level PPTX manipulation |

## MCP Servers for Office
| Project | Tech | Notes |
|---|---|---|
| [sbroenne/mcp-server-excel](https://github.com/sbroenne/mcp-server-excel) | .NET/COM | 25 tools; native COM; Excel-specific |
| [trsdn/mcp-server-ppt](https://github.com/trsdn/mcp-server-ppt) | .NET/COM | PowerPoint COM automation via MCP |
| [GongRzhe/Office-PowerPoint-MCP-Server](https://github.com/GongRzhe/Office-PowerPoint-MCP-Server) | Python/OpenXML | 32 tools; no Office required |

## Microsoft Graph & M365
| Resource | Notes |
|---|---|
| [Microsoft Graph SDK .NET v5](https://github.com/microsoftgraph/msgraph-sdk-dotnet) | Recommended version |
| [PnP Core SDK](https://github.com/pnp/pnpcore) | Higher-level SharePoint/Teams API on top of Graph |
| [Azure.Identity](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/identity/Azure.Identity) | Credential providers |
| [Graph Auth Guide](https://learn.microsoft.com/en-us/graph/sdks/choose-authentication-providers) | Choose the right credential |

## VBA Resources
| Resource | Notes |
|---|---|
| [sancarn/awesome-vba](https://github.com/sancarn/awesome-vba) | Curated VBA library list |
| [sancarn/stdVBA](https://github.com/sancarn/stdVBA) | VBA standard library (std-prefix convention used here) |
| [Rubberduck VBE](https://rubberduckvba.com/) | VBA IDE extension with refactoring + unit tests |

## COM Interop Notes
- All COM calls require **STA thread** — use `ThreadingHelper.RunOnSta()`
- Always call `Marshal.ReleaseComObject()` in `Finally` blocks via `ComReleaser.Release()`
- Reference: [COM RCW memory leaks](https://www.codeproject.com/Articles/347131/NET-COM-interoperation-Fighting-with-RCW-memory-l)
- Never use `DefaultAzureCredential` in production M365 auth — use explicit `AuthMode` enum
