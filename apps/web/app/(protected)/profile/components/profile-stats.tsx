export function ProfileStats() {
  return (
    <div className="grid grid-cols-2 gap-4 text-sm">
      <div className="p-3 border rounded-lg">
        <p className="font-semibold text-muted-foreground">Followers</p>
        <p className="font-mono">124</p>
      </div>
      <div className="p-3 border rounded-lg">
        <p className="font-semibold text-muted-foreground">Following</p>
        <p className="font-mono">89</p>
      </div>
    </div>
  );
}
