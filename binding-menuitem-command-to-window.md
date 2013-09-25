Title: Binding MenuItem command to UserControl property
Autor: Mateusz Œwietlicki
CreateDate: 2013-09-24 13:05
Tags: 	Blog
		EN
		WPF
		.NET

I find myself recently with interesting WPF binding use case. I needed to create ContextMenu/MenuItem which binds CommandParameter property to ViewModel and Command property to CodeBehind. It was nesesary due to fact that it was UserControl and DateContext could not have usercontrol specyfic behavior.

First I tried simply:

```xml
<UserControl x:Name="Root" ...>
...
	<ContextMenu>
		<MenuItem Command="{Binding CopyToClipboardCommand, ElementName=Root}" CommandParameter="{Binding Content}" Header="Kopiuj" />
...
</UserControl>
```

But it didn't work because ContextMenu does not exist in UserControl visual tree.

My problem was solve by binding to PlacementTarget property of ContextMenu and Tag property of parent StackPanel:

```xml
<UserControl x:Name="Root" ...>
	...
	<StackPanel Tag="{Binding ElementName=Root}">
		...
		<StackPanel.ContextMenu>
			<ContextMenu>
				<MenuItem Command="{Binding RelativeSource={RelativeSource AncestorType=ContextMenu}, Path=PlacementTarget.Tag.CopyToClipboardCommand}" CommandParameter="{Binding Content}" Header="Kopiuj" />
			</ContextMenu>
		</StackPanel.ContextMenu>
	</StackPanel>
	...
</UserControl>
```

Little too complex but works fine.