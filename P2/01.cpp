#include<stdio.h>

int n,m,x0,y0,x1,y1,ans=0;
int a[8][8];

void dfs(int x,int y)
{
	if(x==x1&&y==y1)
	{
		ans++;
		return;
	}
	
	if(x+1<=n&&a[x+1][y]==0)
	{
		a[x+1][y]=1;
		dfs(x+1,y);
		a[x+1][y]=0;
	}
	if(x-1>=1&&a[x-1][y]==0)
	{
		a[x-1][y]=1;
		dfs(x-1,y);
		a[x-1][y]=0;
	}
	if(y+1<=m&&a[x][y+1]==0)
	{
		a[x][y+1]=1;
		dfs(x,y+1);
		a[x][y+1]=0;
	}
	if(y-1>=1&&a[x][y-1]==0)
	{
		a[x][y-1]=1;
		dfs(x,y-1);
		a[x][y-1]=0;
	}
}

int main()
{
	scanf("%d%d",&n,&m);
	for (int i=1;i<=n;i++)
		for (int j=1;j<=m;j++)
			scanf("%d",&a[i][j]);
	scanf("%d%d%d%d",&x0,&y0,&x1,&y1);
	a[x0][y0]=1;
	dfs(x0,y0);
	
	printf("%d\n",ans);
	return 0;
}
