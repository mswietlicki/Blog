Title: Get YouTube video upload date
Autor: Mateusz Świetlicki
CreateDate: 2013-07-25 14:40
Tags:	Blog
		EN
		YouTube
		PowerShell
		
Have You ever wonder what is exact upload date of YouTube video? I have. 
Fortunately YouTube provides xml API which enables Us to retrieve all metadata about a video. [YouTube API](https://developers.google.com/youtube/2.0/developers_guide_protocol_video_entries).

I however went one step further and created PowerShell script that gives you exact date in your local timezone.

```powershell
function Get-YTDate{
	Param([String]$id)

	if($id -match '.+?v=(?<id>[\w-]+)'){
		$id = $matches['id']
	}
	$url = "http://gdata.youtube.com/feeds/api/videos/"+$id+"?v=2"
	$xml = [xml](Get-WebContent $url)
	$published = $xml.entry.published
	
	[System.DateTime]::Parse($published)
}
```

<script src="https://gist.github.com/mswietlicki/6079077.js"></script>