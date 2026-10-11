Add-Type -AssemblyName System.Drawing

function Make-GraphicPlaceholder {
    param (
        [string]$FilePath,
        [int]$W,
        [int]$H,
        [string]$Tag,
        [string]$MainText,
        [string]$SubText,
        [int]$BgR, [int]$BgG, [int]$BgB,
        [int]$AccR, [int]$AccG, [int]$AccB
    )

    $bmp = New-Object System.Drawing.Bitmap($W, $H)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    # Background gradient
    $rect = New-Object System.Drawing.Rectangle(0, 0, $W, $H)
    $color1 = [System.Drawing.Color]::FromArgb($BgR, $BgG, $BgB)
    $color2 = [System.Drawing.Color]::FromArgb(12, 12, 16)
    $bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $color1, $color2, 55.0)
    $g.FillRectangle($bgBrush, $rect)

    # Ambient glow orb
    $accentColor = [System.Drawing.Color]::FromArgb($AccR, $AccG, $AccB)
    $glowColor = [System.Drawing.Color]::FromArgb(40, $AccR, $AccG, $AccB)
    $glowBrush = New-Object System.Drawing.SolidBrush($glowColor)
    $g.FillEllipse($glowBrush, [int]($W * 0.5), [int](-$H * 0.1), [int]($W * 0.6), [int]($W * 0.6))
    $secGlow = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30, 108, 99, 255))
    $g.FillEllipse($secGlow, [int](-$W * 0.1), [int]($H * 0.4), [int]($W * 0.5), [int]($W * 0.5))

    # Grid pattern lines
    $gridPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(18, 255, 255, 255), 1)
    for ($x = 40; $x -lt $W; $x += 60) {
        $g.DrawLine($gridPen, $x, 0, $x, $H)
    }
    for ($y = 40; $y -lt $H; $y += 60) {
        $g.DrawLine($gridPen, 0, $y, $W, $y)
    }

    # Outer border
    $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(35, 255, 255, 255), 1)
    $g.DrawRectangle($borderPen, 20, 20, ($W - 40), ($H - 40))

    # Central Glass Card
    $cardW = [int]($W * 0.82)
    $cardH = [int]($H * 0.62)
    $cardX = [int](($W - $cardW) / 2)
    $cardY = [int](($H - $cardH) / 2)
    $cardBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(210, 18, 18, 24))
    $g.FillRectangle($cardBrush, $cardX, $cardY, $cardW, $cardH)

    $cardBorderPen = New-Object System.Drawing.Pen($accentColor, 1.5)
    $g.DrawRectangle($cardBorderPen, $cardX, $cardY, $cardW, $cardH)

    # Accent decorative element inside card
    $decPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(70, $AccR, $AccG, $AccB), 1)
    $g.DrawLine($decPen, ($cardX + 30), ($cardY + 85), ($cardX + $cardW - 30), ($cardY + 85))

    # Typography
    $fontTag = New-Object System.Drawing.Font('Arial', 12, [System.Drawing.FontStyle]::Bold)
    $titleSize = [Math]::Max(18, [int]($H * 0.045))
    $fontTitle = New-Object System.Drawing.Font('Arial', $titleSize, [System.Drawing.FontStyle]::Bold)
    $subSize = [Math]::Max(11, [int]($H * 0.024))
    $fontSub = New-Object System.Drawing.Font('Arial', $subSize, [System.Drawing.FontStyle]::Regular)
    $fontMeta = New-Object System.Drawing.Font('Arial', 10, [System.Drawing.FontStyle]::Regular)

    $brushText = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245, 245, 245))
    $brushAccText = New-Object System.Drawing.SolidBrush($accentColor)
    $brushMuted = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(160, 160, 160))

    # Draw strings
    $g.DrawString($Tag.ToUpper(), $fontTag, $brushAccText, ($cardX + 30), ($cardY + 45))
    $g.DrawString($MainText, $fontTitle, $brushText, ($cardX + 30), ($cardY + 110))
    $g.DrawString($SubText, $fontSub, $brushMuted, ($cardX + 30), ($cardY + 175))

    # Technical markers
    $g.DrawString('+ REMAS ALAA // GRAPHIC DESIGN', $fontMeta, $brushMuted, 40, ($H - 45))
    $g.DrawString('FIG. ARCHIVE / 2026', $fontMeta, $brushAccText, ($W - 200), ($H - 45))

    $bmp.Save($FilePath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Created: $FilePath"
}

# Generate all placeholders
Make-GraphicPlaceholder -FilePath 'c:\Users\remas\OneDrive\Pictures\portfolio\assets\images\profile-placeholder.jpg' -W 800 -H 1000 -Tag 'Creative Portfolio' -MainText 'Remas Alaa' -SubText "Graphic Designer & Visual Identity Specialist`nEgypt // Available for Creative Projects" -BgR 25 -BgG 25 -BgB 32 -AccR 232 -AccG 255 -AccB 106

Make-GraphicPlaceholder -FilePath 'c:\Users\remas\OneDrive\Pictures\portfolio\assets\images\project-01.jpg' -W 1200 -H 800 -Tag 'Packaging Design' -MainText 'Aura Artisan Botanicals' -SubText "Creative packaging concept designed to create a distinctive shelf presence.`nTools: Photoshop · Illustrator" -BgR 22 -BgG 20 -BgB 28 -AccR 232 -AccG 255 -AccB 106

Make-GraphicPlaceholder -FilePath 'c:\Users\remas\OneDrive\Pictures\portfolio\assets\images\project-02.jpg' -W 1200 -H 800 -Tag 'Brand Identity' -MainText 'Lumina Visual System' -SubText "A visual identity system focused on consistency, personality, and strong visual communication.`nTools: Illustrator · Photoshop" -BgR 18 -BgG 24 -BgB 32 -AccR 108 -AccG 99 -AccB 255

Make-GraphicPlaceholder -FilePath 'c:\Users\remas\OneDrive\Pictures\portfolio\assets\images\project-03.jpg' -W 1200 -H 800 -Tag 'Social Media Campaign' -MainText 'Kinetix Digital Momentum' -SubText "A creative promotional campaign designed for high-conversion digital platforms.`nTools: Photoshop · InDesign" -BgR 26 -BgG 20 -BgB 32 -AccR 232 -AccG 255 -AccB 106

Make-GraphicPlaceholder -FilePath 'c:\Users\remas\OneDrive\Pictures\portfolio\assets\images\project-04.jpg' -W 1200 -H 800 -Tag 'Print Design' -MainText 'Velvet Gala Invitation' -SubText "A creative invitation and distribution card developed with a unique visual direction.`nTools: InDesign · Illustrator" -BgR 20 -BgG 28 -BgB 24 -AccR 108 -AccG 99 -AccB 255

Make-GraphicPlaceholder -FilePath 'c:\Users\remas\OneDrive\Pictures\portfolio\assets\images\testimonial-01.jpg' -W 400 -H 400 -Tag 'Client Review' -MainText 'Sarah Mansour' -SubText "Brand Owner & Creative Director" -BgR 24 -BgG 24 -BgB 30 -AccR 232 -AccG 255 -AccB 106

Make-GraphicPlaceholder -FilePath 'c:\Users\remas\OneDrive\Pictures\portfolio\assets\images\testimonial-02.jpg' -W 400 -H 400 -Tag 'Client Review' -MainText 'Karim Tarek' -SubText "Founder, Pulse Media Agency" -BgR 24 -BgG 24 -BgB 30 -AccR 108 -AccG 99 -AccB 255
